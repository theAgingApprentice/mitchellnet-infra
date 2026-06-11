# mitchellnet-infra

mitchellnet-infra is the top-level infrastructure repository for MitchellNET. It does not contain application code. It is the source of truth for the Docker network, SSL certificates, workflow scripts, server setup, architecture documentation, and the operational runbook. It is the first repository cloned on a fresh Ubuntu server rebuild.

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

All services are reachable under `https://mitchellnet.local` via the NGINX reverse proxy.

| Service | URL | Repo | Status |
|---|---|---|---|
| Dashboard | `https://mitchellnet.local/` | [InternalWebServer](https://github.com/theAgingApprentice/InternalWebServer) | Live |
| Fitness Tracker | `https://mitchellnet.local/fitness/` | [fitness-tracker](https://github.com/theAgingApprentice/fitness-tracker) | Live |
| Bench Instrument Service | `https://mitchellnet.local/api/bench/` | [bench-instrument-service](https://github.com/theAgingApprentice/bench-instrument-service) | Live (deployed 4 June 2026) |
| Grafana | `https://mitchellnet.local/grafana/` | [mitchellnet-monitoring](https://github.com/theAgingApprentice/mitchellnet-monitoring) | Planned |
| Prometheus | `https://mitchellnet.local/prometheus/` | [mitchellnet-monitoring](https://github.com/theAgingApprentice/mitchellnet-monitoring) | Planned |
| LibreNMS | `https://mitchellnet.local/librenms/` | [mitchellnet-monitoring](https://github.com/theAgingApprentice/mitchellnet-monitoring) | Planned |
| IoT Device Registry | `https://mitchellnet.local/devices/` | [mitchellnet-device-registry](https://github.com/theAgingApprentice/mitchellnet-device-registry) | Planned |

---

## Repository Map

```
mitchellnet-infra/
├── docs/
│   ├── ARCHITECTURE.md       # Full system design: networking, routing, SSL, CI/CD, IoT
│   ├── deployment-log.md     # Chronological record of service deployments
│   └── runbook.md            # Step-by-step server rebuild and developer workflow guide
├── network/
│   └── create.sh             # Creates the mitchellnet external Docker network
├── scripts/
│   ├── aaGitPromote          # Create branch, stage, commit, push, print PR link
│   ├── aaGitCleanupBranches  # Delete all local/remote branches except main, pull latest
│   ├── aaRegisterRunner      # Register a GitHub Actions self-hosted runner for a repo
│   ├── aaInstall             # Install all scripts in scripts/ to /usr/local/bin
│   └── aaNewService          # Interactive checklist for onboarding a new service repo
├── server-setup/
│   ├── bootstrap.sh          # Full server rebuild entry point (network + SSL + scripts)
│   └── motd/
│       └── motd              # Server message of the day (copy to /etc/motd)
├── ssl/
│   ├── generate.sh           # Generates mkcert wildcard cert for mitchellnet.local
│   └── check-expiry.sh       # Warns if the certificate expiry is within 90 days
├── compose/                  # Reserved for full-stack disaster-recovery Compose file
├── .env.example              # Template for all service environment variables
├── .gitignore                # Excludes .env, ssl/certs/, and other local-only files
├── LICENSE                   # MIT licence
└── README.md                 # This file
```

---

## Quick Start — Fresh Ubuntu Install

Follow these steps in order after a clean Ubuntu Server 24.04 install. See [docs/runbook.md](docs/runbook.md) for full detail on each step.

1. **Install Docker**
   ```bash
   curl -fsSL https://get.docker.com | sh
   sudo usermod -aG docker andrew
   ```

2. **Install mkcert**
   ```bash
   sudo apt install libnss3-tools
   curl -Lo mkcert https://github.com/FiloSottile/mkcert/releases/latest/download/mkcert-v*-linux-amd64
   chmod +x mkcert && sudo mv mkcert /usr/local/bin/mkcert
   ```

3. **Clone this repository**
   ```bash
   git clone https://github.com/theAgingApprentice/mitchellnet-infra.git
   cd mitchellnet-infra
   ```

4. **Create the Docker network**
   ```bash
   bash network/create.sh
   ```

5. **Generate SSL certificates**
   ```bash
   bash ssl/generate.sh
   ```

6. **Configure environment variables**
   ```bash
   cp .env.example .env
   nano .env   # fill in all values — never commit this file
   ```

7. **Run the server bootstrap**
   ```bash
   bash server-setup/bootstrap.sh
   ```

8. **Deploy each service from its own GitHub repo** — clone each service repo to `/home/andrew/services/` and follow its deployment guide. See [docs/runbook.md](docs/runbook.md) for the full procedure.

---

## Scripts

All scripts are prefixed with `aa` and live in `scripts/`. Install them to `/usr/local/bin` on any machine that needs them:

```bash
bash scripts/aaInstall
```

| Script | What it does | When to use it |
|---|---|---|
| `aaGitPromote` | Creates a branch, stages all changes, commits with a message, pushes, and prints a clickable PR link | Every time you want to raise a PR from a service repo |
| `aaGitCleanupBranches` | Deletes all local and remote branches except `main`, then pulls the latest `main` | After a PR is merged and the branch is no longer needed |
| `aaRegisterRunner` | Interactive guide for registering a new GitHub Actions self-hosted runner. Arg: `<repo-name>` | When adding CI/CD to a new or existing service repo |
| `aaInstall` | Copies all scripts in `scripts/` to `/usr/local/bin` and makes them executable | On initial server setup, or after adding a new script |
| `aaNewService` | Interactive checklist for onboarding a new MitchellNET service: creates the GitHub repo, sets branch protection, registers a runner, and clones locally. Arg: `<repo-name>` | Whenever a new service repo is being created from scratch |

---

## Related Repositories

| Repo | GitHub URL | Purpose |
|---|---|---|
| InternalWebServer | [theAgingApprentice/InternalWebServer](https://github.com/theAgingApprentice/InternalWebServer) | NGINX reverse proxy and static dashboard UI |
| fitness-tracker | [theAgingApprentice/fitness-tracker](https://github.com/theAgingApprentice/fitness-tracker) | Calendar-based fitness logging (Flask + MariaDB) |
| bench-instrument-service | [theAgingApprentice/bench-instrument-service](https://github.com/theAgingApprentice/bench-instrument-service) | LXI instrument REST API (FastAPI) |
| mitchellnet-monitoring | [theAgingApprentice/mitchellnet-monitoring](https://github.com/theAgingApprentice/mitchellnet-monitoring) | Grafana, Prometheus, LibreNMS, Telegraf, InfluxDB |
| mitchellnet-device-registry | [theAgingApprentice/mitchellnet-device-registry](https://github.com/theAgingApprentice/mitchellnet-device-registry) | IoT device directory (FastAPI + SQLite) |
| mitchellnet-iot | [theAgingApprentice/mitchellnet-iot](https://github.com/theAgingApprentice/mitchellnet-iot) | Mosquitto MQTT broker configuration |
| christmasTree | [theAgingApprentice/christmasTree](https://github.com/theAgingApprentice/christmasTree) | ESP32 WS2812B LED controller firmware |
| macstudio-setup | [theAgingApprentice/macstudio-setup](https://github.com/theAgingApprentice/macstudio-setup) | Mac Studio developer environment setup and tooling |
| localScripts *(archived)* | — | Retired — scripts migrated to mitchellnet-infra and macstudio-setup |

---

## Development Workflow

mitchellnet-infra and macstudio-setup are the only repositories where direct pushes to `main` are acceptable, because they are infrastructure repos with no deployment pipeline. All service repositories (InternalWebServer, fitness-tracker, bench-instrument-service, and every repo listed above) use the pull-request workflow: create a branch, make changes, then run `aaGitPromote` to push and open a PR. PRs are merged via GitHub; the self-hosted GitHub Actions runner then deploys to the Ubuntu server automatically.

See [docs/runbook.md](docs/runbook.md) for the full developer workflow documentation.

---

## License

MIT — see [LICENSE](LICENSE) for details.
