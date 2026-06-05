# mitchellnet-infra

Top-level infrastructure repository for **MitchellNET** — a self-hosted home network of services running on a 2019 iMac (Ubuntu Server 24.04.2 LTS) at `192.168.2.10`.

This repo does not contain application code. It is the source of truth for:
- The Docker network that connects all services
- SSL certificate generation
- A full-stack Compose file for disaster-recovery rebuilds
- Environment variable templates
- Architecture documentation and the operational runbook

For the full design rationale, see [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

---

## Repository Map

```
mitchellnet-infra/
├── docs/
│   ├── ARCHITECTURE.md       # Full system design document
│   └── runbook.md            # Step-by-step rebuild procedure
├── network/
│   └── create.sh             # Creates the mitchellnet Docker network
├── scripts/
│   ├── aaGitPromote          # Create branch, stage, commit, push, print PR link
│   ├── aaGitCleanupBranches  # Delete all branches except main, pull latest
│   ├── aaRegisterRunner      # Register a GitHub Actions self-hosted runner
│   └── aaInstall             # Install all scripts to /usr/local/bin
├── server-setup/
│   ├── bootstrap.sh          # Full server rebuild entry point
│   └── motd/
│       └── motd              # Server message of the day (copy to /etc/motd)
├── ssl/
│   ├── generate.sh           # Generates mkcert wildcard cert for mitchellnet.local
│   └── check-expiry.sh       # Warns if cert expiry is within 90 days
├── compose/
│   └── docker-compose.yml    # Full-stack Compose (disaster recovery only)
├── .env.example              # Template for all service environment variables
└── README.md                 # This file
```

---

## Scripts

Workflow scripts for managing MitchellNET git operations and server setup. All scripts are prefixed with `aa` and live in `scripts/`. Install them to `/usr/local/bin` on any machine that needs them:

```bash
bash scripts/aaInstall
```

| Script | Description |
|---|---|
| `aaGitPromote` | Creates a branch, stages all changes, commits, pushes, and prints a PR link. Args: `<branch-name> [commit-message]` |
| `aaGitCleanupBranches` | Deletes all local and remote branches except `main`, then pulls the latest `main`. Includes a confirmation prompt. |
| `aaRegisterRunner` | Guides through registering a new GitHub Actions self-hosted runner for a given repo. Arg: `<repo-name>` |
| `aaInstall` | Copies all scripts in `scripts/` to `/usr/local/bin` and makes them executable. |

---

## Host

| Property | Value |
|---|---|
| Hardware | 2019 iMac (iMac19,1) |
| CPU | 3.1 GHz 6-Core Intel Core i5 |
| RAM | 32 GB DDR4 |
| Storage | 1.39 TB |
| OS | Ubuntu Server 24.04.2 LTS |
| LAN IP | `192.168.2.10` |
| Domain | `mitchellnet.local` |

---

## Services

All services are reachable under `https://mitchellnet.local`. No service is accessed by raw IP address or port number — everything routes through the NGINX reverse proxy.

| Service | URL | Repo | Status |
|---|---|---|---|
| Dashboard | `https://mitchellnet.local/` | [InternalWebServer](https://github.com/theAgingApprentice/InternalWebServer) | ✅ Live |
| Fitness Tracker | `https://mitchellnet.local/fitness/` | fitness-tracker | 🔨 Extracting |
| Bench Instrument Service | `https://mitchellnet.local/api/bench/` | bench-instrument-service | ✅ Live |
| Grafana | `https://mitchellnet.local/grafana/` | mitchellnet-monitoring | 🔨 Formalising |
| Prometheus | `https://mitchellnet.local/prometheus/` | mitchellnet-monitoring | 🔨 Formalising |
| LibreNMS | `https://mitchellnet.local/librenms/` | mitchellnet-monitoring | 🔨 Formalising |
| IoT Device Registry | `https://mitchellnet.local/devices/` | mitchellnet-device-registry | 📋 Planned |

---

## Known Port Conflicts

| Host Port | Occupied By | Resolution |
|---|---|---|
| 8000 | LibreNMS (host-mapped) | Bench Instrument Service mapped to host port **8001** (internal port remains 8000) |

> **Note:** BIS listens on port 8000 inside its container. Because LibreNMS already occupies host port 8000, the `bench-instrument-service` docker-compose.yml maps `8001:8000`. NGINX proxies to the container's internal port 8000 by container name — the host port mapping does not affect NGINX routing.

---

## Quick Start — Fresh Ubuntu Install

If you are rebuilding from scratch, follow these steps in order. For full detail on each step, see [docs/runbook.md](docs/runbook.md).

### 1. Prerequisites

```bash
# Install Docker
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker andrew

# Install mkcert
sudo apt install libnss3-tools
curl -Lo mkcert https://github.com/FiloSottile/mkcert/releases/latest/download/mkcert-v*-linux-amd64
chmod +x mkcert && sudo mv mkcert /usr/local/bin/mkcert

# Clone this repo
git clone https://github.com/theAgingApprentice/mitchellnet-infra.git
cd mitchellnet-infra
```

### 2. Create the Docker network

```bash
bash network/create.sh
```

This creates the `mitchellnet` external Docker network that all service containers join. Run this once — it persists across reboots. If it already exists, the script exits cleanly.

### 3. Generate SSL certificates

```bash
bash ssl/generate.sh
```

Generates a wildcard mkcert certificate for `mitchellnet.local` and places the cert and key in `ssl/certs/`. The NGINX container in `InternalWebServer` mounts this directory. Certificates are valid for 10 years and are excluded from version control via `.gitignore`.

### 4. Configure environment variables

```bash
cp .env.example .env
# Edit .env with your actual values
nano .env
```

The `.env` file is excluded from version control. Never commit it.

### 5. Deploy services

Each service deploys from its own repo. Clone them to `/home/andrew/services/` and follow their individual deployment guides:

```bash
mkdir -p /home/andrew/services
cd /home/andrew/services

git clone https://github.com/theAgingApprentice/InternalWebServer.git
# ... repeat for each service repo
```

For a full-stack rebuild using the single Compose file, see [docs/runbook.md](docs/runbook.md).

---

## Server Setup

`server-setup/bootstrap.sh` is the entry point for rebuilding the Ubuntu server from scratch. It runs the full setup sequence in a single command:

```bash
bash server-setup/bootstrap.sh
```

The bootstrap script runs these steps in order:

1. Verifies Docker is installed (exits with install instructions if not)
2. Creates the `mitchellnet` Docker network (`network/create.sh`)
3. Generates the mkcert SSL certificate for `mitchellnet.local` (`ssl/generate.sh`)
4. Installs all scripts from `scripts/` to `/usr/local/bin` (`scripts/aaInstall`)

After bootstrap completes, the remaining manual steps are printed: register a GitHub Actions runner for each service repo using `aaRegisterRunner`, then deploy each service from its own GitHub repo.

The server MOTD is at `server-setup/motd/motd`. Copy it to the Ubuntu server:

```bash
sudo cp server-setup/motd/motd /etc/motd
```

---

## Docker Network

All MitchellNET service containers join a single named external network: `mitchellnet`.

```bash
# Create (run once)
docker network create mitchellnet

# Verify
docker network inspect mitchellnet
```

Services reference it in their `docker-compose.yml` as:

```yaml
networks:
  mitchellnet:
    external: true
```

Container names are DNS hostnames within the network. NGINX routes to services by name (e.g., `http://fitness-tracker:5000`) — no IP addresses, no port-forwarding.

---

## SSL Certificates

MitchellNET uses [mkcert](https://github.com/FiloSottile/mkcert) to generate locally-trusted TLS certificates. SSL terminates at the NGINX reverse proxy. All services behind the proxy communicate over plain HTTP within the `mitchellnet` Docker network.

```bash
# Generate (run once, or after cert expiry)
bash ssl/generate.sh

# Check expiry
bash ssl/check-expiry.sh
```

Generated files (git-ignored):
```
ssl/certs/mitchellnet.local+2.pem      # Certificate
ssl/certs/mitchellnet.local+2-key.pem  # Private key
```

**Note:** mkcert must also be installed and `mkcert -install` run on any machine that needs to trust the certificate (e.g., your Mac for local development).

---

## Environment Variables

Copy `.env.example` to `.env` and fill in values before deploying any service.

```bash
cp .env.example .env
```

The `.env.example` file documents every variable used across all services. The `.env` file is `.gitignore`d and must never be committed.

---

## Related Repositories

| Repo | Purpose |
|---|---|
| [InternalWebServer](https://github.com/theAgingApprentice/InternalWebServer) | NGINX proxy, static web UI |
| [fitness-tracker](https://github.com/theAgingApprentice/fitness-tracker.git) | Calendar-based fitness logging (Flask + MariaDB) |
| [bench-instrument-service](https://github.com/theAgingApprentice/bench-instrument-service.git) | LXI instrument REST API (FastAPI) |
| [mitchellnet-monitoring](https://github.com/theAgingApprentice/mitchellnet-monitoring.git) | Grafana, Prometheus, LibreNMS, Telegraf, InfluxDB |
| [mitchellnet-device-registry](https://github.com/theAgingApprentice/mitchellnet-device-registry.git) | IoT device directory (FastAPI + SQLite) |
| [mitchellnet-iot](https://github.com/theAgingApprentice/mitchellnet-iot.git) | Mosquitto MQTT broker configuration |
| [christmasTree](https://github.com/theAgingApprentice/christmasTree) | ESP32 WS2812B LED controller (IoT device firmware) |

---

## Architecture

The full architecture document covers repo strategy, Docker networking, NGINX routing, SSL, CI/CD patterns, the IoT device registry design, MQTT topic conventions, and the future VLAN network plan.

→ [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

---

## License

MIT — see [LICENSE](LICENSE) for details.
