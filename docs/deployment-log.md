# MitchellNET Deployment Log

A running record of first deployments, significant configuration changes, and lessons learned. One entry per service per phase.

---

## June 11 2026 — Phase 0 Item 3: API Authentication (fitness-tracker + bench-instrument-service)

**PRs:** fitness-tracker #5, #6 | bench-instrument-service #6 | **Repos:** fitness-tracker, bench-instrument-service

### fitness-tracker (Flask)
- Added require_api_key decorator to app/routes/api_routes.py
- Protects all 19 API endpoints; /api/health exempt (Docker healthcheck)
- Uses hmac.compare_digest for timing-safe comparison
- Fail-closed: returns 500 if API_KEY env var is not set
- API key injected server-side into index.html and admin.html via Flask Response
- window.FITNESS_API_KEY populated from API_KEY env var at request time — key never in git
- All fetch() calls in app.js and admin.js updated to send X-API-Key header
- 4 auth tests added; CI workflow fixed to test PR branch (not main) and set API_KEY env var
- API_KEY added to ~/services/fitness-tracker/.env on server

### bench-instrument-service (FastAPI)
- Added verify_api_key dependency to app/dependencies.py
- Applied via dependencies=[Depends(verify_api_key)] on all instrument routers
- /health endpoint left unprotected (Docker healthcheck + uptime monitoring)
- Existing 45 tests protected via dependency_overrides in conftest.py — no test changes required
- 4 new auth tests in tests/test_auth.py with dedicated auth_client fixture
- API_KEY added to ~/services/bench-instrument-service/.env on server

**Security impact:** Closes high finding — all API endpoints require authentication.

---

## June 8 2026 — Phase 0 Item 2: Purge Hardcoded Secrets (Multiple repos)

**PR:** #147 | **Repo:** InternalWebServer + mitchellnet-infra

- Removed hardcoded DB credentials from deploy-to-prod.sh (now reads from .env with fail-fast guards)
- Scrubbed Grafana password and username from networkMonitoring.md
- Replaced real credentials in .env.example with change_me_* placeholders across all repos
- Emptied DB_USER/DB_PASSWORD fallbacks in database.py (fail-closed — no default credentials)
- Parameterised SNMP community string in prometheus.yml
- Updated README.md examples to use placeholder values
- Rotated: fitness_user DB password, MariaDB root password, Grafana admin password
- Created server-side .env files: ~/web_server/.env and ~/services/fitness-tracker/.env
- Created Dev Machine .env at repo root (gitignored)

**Security impact:** Closes high finding — no credentials in version control.

---

## June 8 2026 — Phase 0 Item 1: SSL Key Rotation (InternalWebServer)

**PR:** #146 | **Repo:** InternalWebServer

- Rotated mkcert SSL certificate after dev.key was found committed in git history
- New certificate generated and deployed to ~/web_server/ssl/
- ssl/ directory added to .gitignore to prevent future exposure
- docker-compose.dev.yml retired (was mounting the leaked key)
- Old private key scrubbed from all 299 commits using git-filter-repo
- Force-pushed cleaned history; all collaborators notified to re-clone

**Security impact:** Closes critical finding — leaked private key no longer in repository history.

---

## 2026-06-05 — Script strategy formalised

**What changed:** `macstudio-setup` repo created at https://github.com/theAgingApprentice/macstudio-setup. `localScripts` repo archived. MitchellNET script strategy formalised with scripts split between `mitchellnet-infra/scripts/` (MitchellNET workflow tools, installed on both Mac Studio and Ubuntu server) and `macstudio-setup/scripts/` (personal Mac Studio dev environment tools). See `docs/ARCHITECTURE.md` Section 3 for the full script location reference.

---

## 2026-06-04 — bench-instrument-service — Phase 1 complete

**Service:** bench-instrument-service  
**Phase:** Phase 4, Step 1 (initial live deployment)  
**Status:** ✅ Live at `https://mitchellnet.local/api/bench/`  
**Container:** `bench-instrument-service` · host port 8001 → internal port 8000  

### What was deployed

FastAPI REST API providing LXI/SCPI access to the four bench instruments (Siglent SDS1202X-E, Siglent SDG-2042X, Siglent SDM3055, Rigol DP832). Deployed via self-hosted GitHub Actions runner on the Ubuntu iMac.

### Issues encountered and resolutions

**Port conflict — host port 8000 occupied by LibreNMS**  
LibreNMS was already mapped to host port 8000. The `bench-instrument-service` docker-compose.yml was updated to map `8001:8000` instead. NGINX proxies to `bench-instrument-service:8000` by container name inside the `mitchellnet` network, so the host port change is transparent to all internal routing. See the Known Port Conflicts section in `README.md`.

**Self-hosted runner setup required**  
GitHub-hosted runners cannot reach `192.168.2.10` (LAN-only host). A self-hosted GitHub Actions runner was registered on the Ubuntu iMac and the deploy workflow updated to target `runs-on: self-hosted`. The runner executes `docker compose up -d` directly — no SSH step needed.

**Python virtual environment required for runner**  
The self-hosted runner environment did not have the project's Python dependencies available globally. The deploy workflow was updated to create and activate a Python venv (`python3 -m venv .venv && source .venv/bin/activate`) before running pytest in the CI test step.

**nginx-proxy not on mitchellnet network — 502 errors**  
After the container was running, NGINX returned 502 for all requests to `/api/bench/`. Root cause: the `nginx-proxy` container was not a member of the `mitchellnet` Docker network, so Docker's internal DNS could not resolve `bench-instrument-service` as a hostname. Fixed by adding `mitchellnet` to the networks list for the `nginx-proxy` service in `InternalWebServer`'s `docker-compose.yml`. This is now a permanent configuration — see the note in `docs/ARCHITECTURE.md` Section 3.

**FastAPI Swagger UI broken under subpath — root_path fix**  
The interactive Swagger UI at `/api/bench/docs` had broken asset paths when served behind the NGINX `/api/bench/` prefix. Fixed by setting `root_path="/api/bench"` in the FastAPI app constructor, which causes FastAPI to emit correct absolute paths for all OpenAPI/Swagger assets regardless of the proxy prefix.

### Verification

```bash
curl -k https://mitchellnet.local/api/bench/health
# Expected: {"status": "ok"}

curl -k https://mitchellnet.local/api/bench/docs
# Expected: Swagger UI loads correctly
```

---
