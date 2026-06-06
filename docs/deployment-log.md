# MitchellNET Deployment Log

A running record of first deployments, significant configuration changes, and lessons learned. One entry per service per phase.

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
