# MitchellNET Architecture Design

**Version:** 1.0  
**Host:** Ubuntu Server 24.04.2 LTS · 2019 iMac · `192.168.2.10`  
**Domain:** `mitchellnet.local`  
**Last updated:** June 2026

---

## Table of Contents

1. [Guiding Principles](#1-guiding-principles)
2. [Repository Strategy](#2-repository-strategy)
3. [Script Strategy](#3-script-strategy)
4. [Docker Networking](#4-docker-networking)
5. [NGINX Routing](#5-nginx-routing)
6. [SSL Strategy](#6-ssl-strategy)
7. [CI/CD Pattern](#7-cicd-pattern)
8. [Service Inventory](#8-service-inventory)
9. [Fitness Tracker Extraction Plan](#9-fitness-tracker-extraction-plan)
10. [IoT Device Registry](#10-iot-device-registry)
11. [MQTT Topic Convention](#11-mqtt-topic-convention)
12. [Future Network Architecture](#12-future-network-architecture)
13. [Implementation Roadmap](#13-implementation-roadmap)

---

## 1. Guiding Principles

Every architectural decision flows from three constraints unique to MitchellNET:

- **Single physical host** — one Ubuntu iMac, no distributed systems complexity
- **LAN-only** — no public internet exposure, no cloud dependencies
- **Solo operator** — one person builds, deploys, and maintains everything

From these constraints, three rules govern all design decisions:

**Rule 1 — Everything in git.** No service runs from files copied by hand. No configuration exists only on disk. If it can't be reproduced from a repository, it doesn't belong in MitchellNET.

**Rule 2 — Every service is independently deployable.** A broken deploy of one service must not affect any other. Services are loosely coupled through Docker networking and NGINX proxy, not through shared Compose stacks.

**Rule 3 — The `mitchellnet` Docker network is the backbone.** All services join this named network. NGINX resolves services by container name. No service is accessed by raw IP address or port from within the stack.

---

## 2. Repository Strategy

Seven repositories, each with a single clear responsibility.

### `InternalWebServer` (existing)
The front door of MitchellNET. Owns:
- NGINX reverse proxy configuration
- SSL certificate mounting
- Static web UI (dashboard, home page)
- NGINX `location` blocks for all services

Does **not** own any application business logic. When a new service is added to MitchellNET, this is the only repo that gains a new `location` block — nothing else changes here.

### `fitness-tracker` (extract from InternalWebServer)
Currently embedded in InternalWebServer. After extraction, owns:
- Flask backend (`Python 3.11`)
- Frontend HTML/CSS/JS
- MariaDB container and volume
- Its own `docker-compose.yml`, `Dockerfile`, and CI/CD pipeline

See [Section 9](#9-fitness-tracker-extraction-plan) for the migration plan.

### `bench-instrument-service` (new — Step 1)
FastAPI REST API abstracting the four LXI/Ethernet bench instruments:
- Siglent SDS1202X-E oscilloscope
- Siglent SDG-2042X signal generator
- Siglent SDM3055 multimeter
- Rigol DP832 power supply

### `mitchellnet-monitoring` (formalise existing)
The Prometheus + Grafana + LibreNMS + Telegraf + InfluxDB stack currently running ad-hoc. This repo brings it under version control:
- `docker-compose.yml` for the full monitoring stack
- Prometheus scrape configs (`prometheus.yml`)
- Grafana dashboard JSON files (provisioned automatically on container start)
- Grafana datasource provisioning configs
- Telegraf config
- LibreNMS config exports

All dashboards live as JSON files in this repo. Grafana is configured with `GF_DASHBOARDS_DEFAULT_HOME_DASHBOARD_PATH` pointing to the provisioning directory — dashboards are never edited in the UI without committing the JSON export.

### `mitchellnet-device-registry` (new)
FastAPI service providing the IoT device directory. See [Section 9](#9-iot-device-registry).

### `mitchellnet-iot` (future)
Mosquitto MQTT broker configuration, topic documentation, and any server-side IoT ingestion logic. Currently Mosquitto runs ad-hoc — this repo formalises it with the same discipline as monitoring.

### `mitchellnet-infra` (this repo)
Top-level orchestration. Does **not** contain application code. Contains:
- `network/create.sh` — creates the `mitchellnet` Docker network
- `ssl/generate.sh` — mkcert certificate generation for `mitchellnet.local`
- `compose/docker-compose.yml` — full-stack Compose using [include directives](https://docs.docker.com/compose/multiple-compose-files/include/) pointing to each service repo; used for disaster-recovery rebuilds, not day-to-day deploys
- `.env.example` — template for all environment variables across all services
- `docs/ARCHITECTURE.md` — this document
- `docs/runbook.md` — step-by-step rebuild procedure for a fresh Ubuntu install

---

## 3. Script Strategy

MitchellNET workflow scripts live in `mitchellnet-infra/scripts/` and are installed to `/usr/local/bin` on both the Mac Studio and the Ubuntu server by running:

```bash
bash scripts/aaInstall
```

This makes all `aa`-prefixed scripts available as system-wide commands on any machine that runs the install. Scripts cover git workflow (branch, commit, push), branch cleanup, GitHub Actions runner registration, and the install mechanism itself.

Personal Mac Studio developer environment tools live in the separate [macstudio-setup](https://github.com/theAgingApprentice/macstudio-setup) repo. The `localScripts` repo has been archived as of June 2026 — all relevant scripts have been migrated to either `mitchellnet-infra/scripts/` or `macstudio-setup/scripts/`.

### Script location reference

| Location | Scripts | Purpose |
|---|---|---|
| `mitchellnet-infra/scripts/` | `aaGitPromote`, `aaGitCleanupBranches`, `aaRegisterRunner`, `aaInstall` | MitchellNET workflow tools — installed on both Mac Studio and Ubuntu server |
| `macstudio-setup/scripts/` | `aaCopyMotd`, `aaCopyScripts`, `aaHelp`, `aaGoMqtt`, `install.sh` | Personal Mac Studio dev environment tools |
| `mitchellnet-iot/` | `aaMqtt` | IoT/MQTT tools (future) |

---

## 4. Docker Networking

### The `mitchellnet` named network

One external Docker network connects all services:

```bash
docker network create mitchellnet
```

Every service's `docker-compose.yml` declares it as external:

```yaml
networks:
  mitchellnet:
    external: true
```

This means:
- NGINX can reach any service container by its Docker service name as a DNS hostname (e.g., `http://fitness-tracker:5000`)
- No raw IP addresses in NGINX configs
- No port mapping required for internal service-to-service communication
- Services can be deployed from separate Compose stacks without coordination

### Internal isolation networks

Each service that has a sidecar database (e.g., fitness-tracker + MariaDB) also defines an internal network that is **not** `mitchellnet`. The database container joins only the internal network — it is never reachable from other services or from NGINX. Only the application container joins both networks.

```yaml
# fitness-tracker/docker-compose.yml
services:
  fitness-tracker:
    networks:
      - mitchellnet      # reachable by NGINX
      - fitness-internal # can reach its own db

  mariadb:
    networks:
      - fitness-internal # NOT on mitchellnet

networks:
  mitchellnet:
    external: true
  fitness-internal:
    internal: true
```

### nginx-proxy must be on the mitchellnet network

For NGINX to resolve upstream container hostnames (e.g., `http://bench-instrument-service:8000`), the `nginx-proxy` container itself must be a member of the `mitchellnet` network — not just the service containers. Without this, Docker's internal DNS cannot resolve the container names and NGINX returns a 502.

This is now configured permanently in `InternalWebServer`'s `docker-compose.yml` by declaring `mitchellnet` as a network for the `nginx-proxy` service. Do not remove this network attachment.

### Container naming convention

Container names are the DNS names used by NGINX. Use consistent, predictable names:

| Service | Container name | Port (internal) |
|---|---|---|
| NGINX proxy | `nginx-proxy` | 80, 443 |
| Fitness Tracker | `fitness-tracker` | 5000 |
| Bench Instrument Service | `bench-instrument-service` | 8000 |
| Grafana | `grafana` | 3000 |
| Prometheus | `prometheus` | 9090 |
| LibreNMS | `librenms` | 8080 |
| InfluxDB | `influxdb` | 8086 |
| Mosquitto | `mosquitto` | 1883 |
| Device Registry | `device-registry` | 8001 |

---

## 5. NGINX Routing

NGINX in `InternalWebServer` is the canonical URL map for all of MitchellNET. All services are reachable under `https://mitchellnet.local`. No service is accessed by raw port number.

### URL map

| Path prefix | Routes to | Notes |
|---|---|---|
| `/` | Static web root | Dashboard, home page |
| `/fitness/` | `fitness-tracker:5000` | Extracted app |
| `/fitness/api/` | `fitness-tracker:5000/api/` | Flask API (scoped under service path) |
| `/api/bench/` | `bench-instrument-service:8000` | BIS FastAPI |
| `/grafana/` | `grafana:3000` | Requires Grafana subpath config |
| `/prometheus/` | `prometheus:9090` | Internal access only |
| `/librenms/` | `librenms:8080` | SNMP network monitoring |
| `/devices/` | `device-registry:8001` | IoT device registry UI + API |

### Grafana subpath configuration

When proxied under `/grafana/`, Grafana requires two environment variables in its container:

```yaml
environment:
  GF_SERVER_ROOT_URL: https://mitchellnet.local/grafana/
  GF_SERVER_SERVE_FROM_SUB_PATH: "true"
```

Without these, Grafana's asset paths break.

### NGINX config pattern

```nginx
location /fitness/ {
    proxy_pass http://fitness-tracker:5000/;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
}
```

Note the trailing slash on both `location` and `proxy_pass` — this strips the prefix before forwarding to the container.

---

## 6. SSL Strategy

SSL terminates at NGINX. All services behind the proxy communicate over plain HTTP on the `mitchellnet` Docker network. No per-service certificate management.

**Tool:** `mkcert` — generates locally-trusted certificates for `mitchellnet.local`.  
**Certificate location on host:** `/home/andrew/web_server/ssl/` (mounted into the NGINX container).  
**Certificate lifetime:** mkcert certificates are valid for 10 years.

The `mitchellnet-infra` repo contains `ssl/generate.sh`:

```bash
#!/bin/bash
mkcert -install
mkcert mitchellnet.local "*.mitchellnet.local" localhost 127.0.0.1
```

The wildcard SAN (`*.mitchellnet.local`) covers all current and future services without certificate regeneration.

**Renewal reminder:** Add a cron job or systemd timer on the Ubuntu host to check certificate expiry and log a warning 90 days before expiry. Store the check script in `mitchellnet-infra/ssl/check-expiry.sh`.

---

## 7. CI/CD Pattern

Each service repo uses GitHub Actions with a consistent deployment pattern.

### Workflow: PR → test → deploy

```
PR opened
  └─ Run tests (pytest / unit tests)
  └─ Lint (flake8, eslint)
  └─ Build Docker image (verify it builds)

Merge to main
  └─ Build and tag Docker image
  └─ SSH to 192.168.2.10
  └─ docker compose pull <service>
  └─ docker compose up -d --no-deps <service>
  └─ Health check: curl https://mitchellnet.local/<service>/health
  └─ Report success/failure
```

The `--no-deps` flag is critical — it restarts only the changed container without touching dependent services or the NGINX proxy.

### GitHub Actions secrets (per repo)

| Secret | Value |
|---|---|
| `PROD_HOST` | `192.168.2.10` |
| `PROD_USER` | `andrew` |
| `PROD_SSH_KEY` | Private key for deploy user |

No secrets in code, no secrets in Docker images, no secrets in Compose files committed to git. All runtime secrets are passed as environment variables from `.env` files on the host, excluded from version control via `.gitignore`.

### The production directory is a git checkout

**This is a departure from the current setup.** Currently `/home/andrew/web_server` is not a git repository — files are copied via SCP. Under the new architecture, each service is deployed to its own directory that **is** a git checkout. The GitHub Actions deploy step runs `git pull` (or `docker compose pull`) rather than copying files.

```
/home/andrew/services/
├── InternalWebServer/     # git checkout of InternalWebServer
├── fitness-tracker/       # git checkout of fitness-tracker
├── bench-instrument-service/
├── mitchellnet-monitoring/
└── mitchellnet-device-registry/
```

---

## 8. Service Inventory

### Currently running (as of June 2026)

| Service | Technology | Status | Repo | Container Name | Host Port | Internal Port | Deployed | Notes |
|---|---|---|---|---|---|---|---|---|
| NGINX proxy | nginx:1.29 | ✅ Running | InternalWebServer | `nginx-proxy` | 80, 443 | 80, 443 | — | SSL termination |
| Fitness Tracker | Flask + MariaDB | ✅ Running | InternalWebServer (embedded) | `fitness-tracker` | — | 5000 | — | Needs extraction |
| Bench Instrument Service | FastAPI | ✅ Live | bench-instrument-service | `bench-instrument-service` | 8001 | 8000 | 2026-06-04 | Host port 8001 due to LibreNMS conflict on 8000 |
| Grafana | Grafana OSS | ✅ Running | ad-hoc | `grafana` | — | 3000 | — | Needs formalising |
| Prometheus | Prometheus | ✅ Running | ad-hoc | `prometheus` | — | 9090 | — | Needs formalising |
| LibreNMS | LibreNMS | ✅ Running | ad-hoc | `librenms` | 8000 | 8080 | — | SNMP monitoring |
| Telegraf | Telegraf | ✅ Running | ad-hoc | `telegraf` | — | — | — | Metrics collection |
| InfluxDB | InfluxDB | ✅ Running | ad-hoc | `influxdb` | — | 8086 | — | Time-series DB |
| Mosquitto | Eclipse Mosquitto | ✅ Running | ad-hoc | `mosquitto` | — | 1883 | — | MQTT broker |
| Node Exporter | Prometheus exporter | ✅ Running | ad-hoc | `node-exporter` | — | 9100 | — | Host metrics |
| Blackbox Exporter | Prometheus exporter | ✅ Running | ad-hoc | `blackbox-exporter` | — | 9115 | — | Endpoint probing |
| MariaDB | MariaDB 10.7 | ✅ Running | InternalWebServer (embedded) | `mariadb-prod` | — | 3306 | — | Fitness Tracker DB |
| UniFi Controller | UniFi Network App | ✅ Running | ad-hoc | `unifi` | — | — | — | AP management |

### Planned / in progress

| Service | Technology | Status | Repo |
|---|---|---|---|
| IoT Device Registry | FastAPI + SQLite | 📋 Planned | mitchellnet-device-registry |

---

## 9. Fitness Tracker Extraction Plan

The Fitness Tracker is currently embedded in `InternalWebServer`. Extracting it is the highest-priority refactoring task because it proves the "new service" pattern and cleans up the foundational InternalWebServer repo.

### What needs to move

- `backend/fitnessTracker/` → new repo root
- `html/prod/fitnessTracker/` → new repo `frontend/`
- `database/fitnessTracker/structure/*.sql` → new repo `database/`
- The `mariadb-prod` and `fitness-tracker-backend-prod` service definitions from `docker-compose.yml`

### API path change required

The current API path `/api` must become `/fitness/api` to avoid namespace collisions as more services are added. Changes required:

1. In `html/prod/fitnessTracker/js/app.js`: change `API_BASE_URL` from `/api` to `/fitness/api`
2. In the new repo's NGINX `location` block: route `/fitness/api/` → `fitness-tracker:5000/api/`
3. In InternalWebServer's `nginx/conf.d/prod.conf`: remove the existing `/api/` block and replace with the scoped version

### MariaDB data migration

The production database has 670+ real activity log entries in a named Docker volume (`mariadb_prod_data`). Migration procedure:

```bash
# 1. Dump the production database before any changes
ssh andrew@192.168.2.10 \
  "docker exec mariadb-prod mysqldump -u fitness_user -pfitness_password fitness_tracker_prod" \
  > fitness_tracker_prod_backup_$(date +%Y%m%d).sql

# 2. After new container is running in new repo:
cat fitness_tracker_prod_backup_YYYYMMDD.sql | \
  ssh andrew@192.168.2.10 \
  "docker exec -i fitness-tracker-mariadb mysql -u fitness_user -pfitness_password fitness_tracker_prod"

# 3. Verify row counts match
ssh andrew@192.168.2.10 \
  "docker exec fitness-tracker-mariadb mysql -u fitness_user -pfitness_password \
   fitness_tracker_prod -e 'SELECT COUNT(*) FROM activityLog;'"
```

### Two NGINX containers

The current stack has both `nginx-proxy` and `nginx-prod` containers. During extraction, rationalise to a single `nginx-proxy` container. The `nginx-prod` container appears to be a legacy artefact — confirm it serves no unique purpose before removing.

### Extraction sequence (zero-downtime)

1. Create `fitness-tracker` repo, copy code, write `Dockerfile`, write `docker-compose.yml` (joins `mitchellnet`, has internal MariaDB network)
2. Deploy new stack alongside existing — new containers run on the `mitchellnet` network but NGINX doesn't route to them yet
3. Dump and restore production data into new MariaDB volume
4. Update InternalWebServer NGINX config to route `/fitness/` to new container — test thoroughly
5. Verify everything works via `https://mitchellnet.local/fitness/`
6. Remove fitness tracker service definitions from InternalWebServer's `docker-compose.yml`
7. Stop and remove old `mariadb-prod` and `fitness-tracker-backend-prod` containers

---

## 10. IoT Device Registry

A FastAPI service that maintains a directory of every IoT device on MitchellNET — permanent, seasonal, and workshop. It is a **read/write directory**, not a control plane. Commands go via MQTT topics directly; the registry tells you what topics to use.

### Repository: `mitchellnet-device-registry`

```
mitchellnet-device-registry/
├── app/
│   ├── main.py          # FastAPI app, includes all routers
│   ├── models.py        # SQLModel device schema
│   ├── routers/
│   │   ├── devices.py   # CRUD endpoints
│   │   └── health.py    # Health check
│   ├── mqtt.py          # Mosquitto subscriber (status + register topics)
│   └── db.py            # SQLite init and session management
├── frontend/
│   └── index.html       # Device dashboard (served by FastAPI static files)
├── Dockerfile
├── docker-compose.yml
└── .github/workflows/deploy.yml
```

### Device record schema

```json
{
  "id": "christmas-tree",
  "name": "Christmas Tree",
  "description": "WS2812B LED strip controller, 300 LEDs, Indian inlay table",
  "hardware": "Freenove ESP32-WROOM-32 v1.3",
  "location": "living-room",
  "seasonal": true,
  "active": true,
  "mac": "14:08:08:AB:51:4C",
  "ip": "192.168.2.159",
  "vlan": 30,
  "last_seen": "2026-06-03T14:22:00Z",
  "web_url": "http://192.168.2.159",
  "mqtt": {
    "broker": "192.168.2.10",
    "cmd_topic": "mitchellnet/living-room/christmas-tree/cmd",
    "msg_topic": "mitchellnet/living-room/christmas-tree/msg",
    "log_topic": "mitchellnet/living-room/christmas-tree/log",
    "status_topic": "mitchellnet/living-room/christmas-tree/status",
    "commands": ["christmas", "rainbow", "allRed", "showStatus", "help"]
  },
  "ota": {
    "hostname": "ChristmasTree-140808AB514C",
    "port": 3232
  },
  "tags": ["led", "seasonal", "christmas", "living-room"]
}
```

### Registration modes

**Self-registration (new devices with updated firmware):** On boot, the device publishes its identity JSON to `mitchellnet/{location}/{device-id}/register`. The registry service subscribes to `mitchellnet/+/+/register` and upserts the record.

**Manual registration:** `POST /api/devices` for devices that can't be reflashed immediately.

**Automatic status updates:** The registry subscribes to `mitchellnet/+/+/status` and updates `last_seen` and `ip` on every heartbeat — handles DHCP lease changes transparently.

### API endpoints

```
GET    /api/devices              List all devices (filterable by location, seasonal, active)
GET    /api/devices/{id}         Get single device
POST   /api/devices              Create device record
PUT    /api/devices/{id}         Update device record
DELETE /api/devices/{id}         Delete device record
GET    /api/devices/{id}/status  Last heartbeat and current IP
GET    /health                   Health check
```

### Dashboard

The frontend at `https://mitchellnet.local/devices/` shows:
- All devices grouped by location
- Online/offline status (green/grey) based on last heartbeat age
- Direct links to each device's web interface
- MQTT topic quick-reference per device
- Toggle: "show only seasonal" / "show only active"

---

## 11. MQTT Topic Convention

### Hierarchy

```
mitchellnet/{location}/{device-id}/{type}
```

**Location values:** `living-room`, `kitchen`, `workshop`, `garage`, `lab`, `outdoor`, `office`

**Type values:**

| Type | Direction | Description |
|---|---|---|
| `cmd` | → device | Commands sent to the device |
| `msg` | ← device | Status/response messages from device |
| `log` | ← device | Console/debug log output |
| `status` | ← device | Heartbeat JSON (IP, firmware version, uptime) |
| `register` | ← device | Boot-time self-registration payload |

### Heartbeat payload (`status` topic)

Published by device every 60 seconds:

```json
{
  "device_id": "christmas-tree",
  "ip": "192.168.2.159",
  "mac": "14:08:08:AB:51:4C",
  "firmware": "6.0.0",
  "uptime_s": 3600,
  "rssi": -52,
  "timestamp": "2026-06-03T14:22:00Z"
}
```

### Migration from legacy topics

The Christmas Tree currently uses flat topics (`christmasTree-cmd`, `christmasTree-msg`, `christmasTree-log`). Migration to the new hierarchy requires a firmware update (deployable via OTA). Until migration, the device registry stores both old and new topic names during the transition.

**Target topics after migration:**
```
mitchellnet/living-room/christmas-tree/cmd
mitchellnet/living-room/christmas-tree/msg
mitchellnet/living-room/christmas-tree/log
mitchellnet/living-room/christmas-tree/status
mitchellnet/living-room/christmas-tree/register
```

### Location-wide subscriptions

Useful patterns enabled by the hierarchy:

```bash
# All commands going to any living room device
mosquitto_sub -t "mitchellnet/living-room/+/cmd"

# All status heartbeats from all devices
mosquitto_sub -t "mitchellnet/+/+/status"

# Everything from the Christmas tree
mosquitto_sub -t "mitchellnet/living-room/christmas-tree/#"
```

---

## 12. Future Network Architecture

The planned network upgrade (OPNsense firewall + managed switching + UniFi APs + VLANs) does not require changes to the MitchellNET software architecture, but the following design decisions should be made **before** the network cutover.

### VLAN assignments (planned)

| VLAN | Name | Subnet | Hosts |
|---|---|---|---|
| 10 | Management | 192.168.10.0/24 | Ubuntu server, NAS, trusted devices |
| 20 | Main | 192.168.20.0/24 | Laptops, phones, desktops |
| 30 | IoT | 192.168.30.0/24 | ESP32/ESP8266 devices, smart home |
| 40 | Lab | 192.168.40.0/24 | Bench instruments, workshop devices |
| 99 | Guest | 192.168.99.0/24 | Guest WiFi, isolated |

### Firewall rules that affect MitchellNET services

- **IoT → MQTT:** VLAN 30 devices need a single firewall rule permitting TCP port 1883 to `192.168.10.x` (the Ubuntu server). All other IoT traffic blocked.
- **Lab → BIS:** VLAN 40 (bench instruments) needs TCP access to their respective instrument ports. The BIS container on the Ubuntu server communicates with instruments via the lab VLAN.
- **IoT self-registration:** Devices on VLAN 30 need to reach Mosquitto on port 1883 only — the self-registration flow uses MQTT, so no additional ports required.

### The DMZ Raspberry Pi

When the DMZ Pi is added, it becomes a second host in `mitchellnet-infra`. Services that can tolerate external exposure (a future external-facing status page, VPN endpoint) move there. Services that must stay internal (BIS, Grafana, Fitness Tracker) remain on the iMac. The `mitchellnet-infra` runbook documents both hosts.

### DNS after OPNsense

`mitchellnet.local` resolves via the Ubuntu server's DNS (currently providing DHCP+DNS for the LAN). After OPNsense is deployed, OPNsense handles DHCP and forwards DNS to either the Ubuntu server or an upstream resolver. The `mitchellnet.local` A record pointing to `192.168.2.10` (or its new VLAN 10 address) must be maintained in whichever DNS service takes over. No application changes required.

---

## 13. Implementation Roadmap

### Phase 1 — Foundation (do first, no service disruption)

1. Create `mitchellnet-infra` repo
2. Run `docker network create mitchellnet`
3. Document the network creation in `network/create.sh`
4. Generate wildcard mkcert cert and commit `ssl/generate.sh`
5. Verify existing NGINX container can join `mitchellnet` network

### Phase 2 — Formalise monitoring (quick wins, high value)

1. Create `mitchellnet-monitoring` repo
2. Write `docker-compose.yml` matching the current ad-hoc Grafana + Prometheus + LibreNMS + Telegraf + InfluxDB stack
3. Export all Grafana dashboards to JSON, commit to repo, configure Grafana provisioning
4. Add Grafana and Prometheus to `mitchellnet` network
5. Add NGINX `location /grafana/` and `location /prometheus/` blocks
6. Add `GF_SERVER_ROOT_URL` and subpath config to Grafana container
7. Verify dashboards load at `https://mitchellnet.local/grafana/`
8. Close direct port access (`:3000`, `:9090`) — access only through NGINX

### Phase 3 — Extract Fitness Tracker

1. Create `fitness-tracker` repo
2. Copy application code, write `Dockerfile`
3. Write `docker-compose.yml` with `mitchellnet` + internal MariaDB network
4. Set up GitHub Actions CI/CD (copy pattern from InternalWebServer)
5. Update API paths from `/api` to `/fitness/api` in `app.js`
6. Deploy alongside existing stack (no NGINX routing yet)
7. Dump and restore production MariaDB data
8. Update InternalWebServer NGINX config to route `/fitness/` to new container
9. Verify at `https://mitchellnet.local/fitness/`
10. Remove fitness tracker from InternalWebServer Compose stack

### Phase 4 — Bench Instrument Service (new build)

Detailed implementation plan to be written separately. High-level:

1. Create `bench-instrument-service` repo
2. Implement FastAPI with LXI/SCPI instrument drivers
3. Deploy container, add NGINX routing for `/api/bench/`
4. Write instrument abstraction layer per the BIS Architecture & Requirements document

### Phase 5 — IoT Device Registry (new build)

1. Create `mitchellnet-device-registry` repo
2. Implement FastAPI + SQLite backend
3. Add MQTT subscriber for status and register topics
4. Build device dashboard frontend
5. Manually register Christmas Tree as first device
6. Update Christmas Tree firmware to use new topic hierarchy and self-register on boot

### Phase 6 — Formalise remaining ad-hoc services

1. Create `mitchellnet-iot` repo for Mosquitto configuration
2. Bring UniFi Controller under version control
3. Document Mosquitto authentication configuration (currently anonymous — add credentials before VLAN cutover)

### Phase 7 — VLAN network upgrade

Pre-requisites before cutting over:
- All services behind NGINX (no raw port access)
- Mosquitto authentication enabled
- IoT devices updated to new MQTT topic hierarchy
- VLAN firewall rules designed and documented in `mitchellnet-infra`
- DNS plan confirmed for `mitchellnet.local` resolution after OPNsense takes over DHCP

---

## Appendix: Known Issues to Resolve

| Issue | Impact | Resolution |
|---|---|---|
| `/home/andrew/web_server` is not a git repo | Deployments require SCP; no rollback | Migrate to git-checkout deploy in Phase 1–3 |
| Two NGINX containers (`nginx-proxy` + `nginx-prod`) | Unclear which is authoritative | Rationalise to single container during Fitness Tracker extraction |
| Christmas Tree MQTT broker IP hardcoded as `192.168.2.21` | May not reach broker | Verify correct IP is `192.168.2.10`; fix in firmware |
| Grafana, Prometheus, etc. exposed on raw ports | No SSL, no access control | Resolved in Phase 2 |
| Mosquitto running with anonymous access | Security risk, especially before VLAN segmentation | Add credentials before Phase 6/7 |
| No Grafana dashboard backups | Dashboard loss on container rebuild | Resolved in Phase 2 via JSON provisioning |
