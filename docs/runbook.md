# MitchellNET Runbook

Step-by-step procedures for rebuilding or extending MitchellNET infrastructure. For system design rationale, see [ARCHITECTURE.md](ARCHITECTURE.md).

---

## Developer Workflow

### Standard flow

All work on service repos goes through pull requests. Never push directly to `main` on a service repo.

Use `aaGitPromote` to stage, commit, push, and open a PR in one step:

```
1. Make changes locally
2. aaGitPromote <branch-name> "commit message"
3. Open the PR link it prints
4. Wait for status checks to pass
5. Merge the PR on GitHub
6. aaGitCleanupBranches
```

### Scripts reference

| Script | What it does | When to use |
|---|---|---|
| `aaGitPromote` | Stages all changes, commits, pushes to a branch, and prints a PR link | Every time you want to open a PR |
| `aaGitCleanupBranches` | Switches to `main`, pulls latest, deletes merged local branches | After merging a PR |
| `aaRegisterRunner` | Registers a GitHub Actions self-hosted runner for a repo on the Ubuntu server | When adding CI/CD to a new service repo |
| `aaInstall` | Copies all scripts from `mitchellnet-infra/scripts/` to `/usr/local/bin` | After cloning mitchellnet-infra or updating any script |
| `aaNewService` | Walks interactively through the full setup checklist for a new service repo | When creating a new MitchellNET service |

### Installing scripts

Scripts must be installed to `/usr/local/bin` before they can be run from anywhere. From the `mitchellnet-infra` repo root:

```bash
bash scripts/aaInstall
```

Re-run this any time a script is added or updated. This works on both Mac Studio and the Ubuntu server.

### Branch protection rules

All MitchellNET service repos use these settings (classic branch protection rule for `main`):

- **Require a pull request before merging** — no direct pushes to `main`
- **Require status checks to pass** — the deploy workflow must succeed before merging
- **No approving reviews required** — solo developer, self-approval is fine
- **Do not allow bypassing** — the rules apply even to repo admins

> Note: Branch protection rules are only enforced on public repositories under the GitHub Free plan. All service repos must be public.

### Setting up a new service repo

Run the interactive setup script:

```bash
aaNewService <repo-name>
```

This walks through every step: creating the GitHub repo, adding branch protection, registering the runner, cloning locally, and prints a checklist of what still needs to be done manually (Dockerfile, docker-compose.yml, deploy workflow, etc.). See the script itself for full details.

### Repo-specific notes

`mitchellnet-infra` and `macstudio-setup` have no CI/CD pipeline. Direct pushes to `main` are acceptable for those two repos only.

---

## Mac Studio Setup

To set up a new Mac Studio development environment:

1. Clone the macstudio-setup repo and run the install script:

   ```bash
   git clone https://github.com/theAgingApprentice/macstudio-setup.git
   cd macstudio-setup
   bash scripts/install.sh
   ```

   This handles Homebrew, mkcert, all custom scripts, and MOTD.

2. Clone the MitchellNET service repos to `~/Documents/visualStudioCode/`:

   ```bash
   mkdir -p ~/Documents/visualStudioCode
   cd ~/Documents/visualStudioCode

   git clone https://github.com/theAgingApprentice/mitchellnet-infra.git
   git clone https://github.com/theAgingApprentice/InternalWebServer.git
   # Repeat for each service repo as needed
   ```

3. Add the MitchellNET server to `/etc/hosts`:

   ```bash
   echo "192.168.2.10 mitchellnet.local" | sudo tee -a /etc/hosts
   ```

4. Install mkcert and trust the local CA so `https://mitchellnet.local` is trusted in your browser:

   ```bash
   mkcert -install
   ```

---

## Ubuntu Server Rebuild

To rebuild the Ubuntu server from scratch:

1. Install Docker:

   ```bash
   curl -fsSL https://get.docker.com | sh
   sudo usermod -aG docker andrew
   ```

2. Clone `mitchellnet-infra` and run the bootstrap script:

   ```bash
   git clone https://github.com/theAgingApprentice/mitchellnet-infra.git
   cd mitchellnet-infra
   bash server-setup/bootstrap.sh
   ```

   This runs the full setup sequence: creates the `mitchellnet` Docker network, generates the mkcert SSL certificate for `mitchellnet.local`, and installs all scripts from `scripts/` to `/usr/local/bin`.

3. Register a GitHub Actions self-hosted runner for each service repo:

   ```bash
   aaRegisterRunner <repo-name>
   ```

   Repeat for each repo that has a deploy workflow (e.g., `InternalWebServer`, `bench-instrument-service`, `fitness-tracker`).

4. Trigger each service's deployment workflow from GitHub Actions (Actions tab → select workflow → Run workflow), or push a commit to `main` in each repo to trigger the deploy.

5. Verify services are reachable at `https://mitchellnet.local`.

---

## Updating the MOTD

The server MOTD is managed in `server-setup/motd/motd`. To update it on the live server:

```bash
sudo cp server-setup/motd/motd /etc/motd
```

---

## SSL Certificate Renewal

mkcert certificates are valid for 10 years. To check expiry:

```bash
bash ssl/check-expiry.sh
```

To regenerate:

```bash
bash ssl/generate.sh
```

Certs are written to `ssl/certs/` (git-ignored). After regeneration, restart the NGINX container so it picks up the new certificate.

---

## NGINX Proxy Pass Pattern

MitchellNET uses **Approach A** for all services proxied through NGINX: NGINX carries a trailing slash on `proxy_pass`, and backend services use simple routes with no path prefix.

### How it works

- **NGINX**: `proxy_pass http://service-name:port/;` — trailing slash present
- **Backend** (Flask and all other services): `@app.route('/')`, `@app.route('/api/health')` — no location prefix in routes

The trailing slash on `proxy_pass` causes NGINX to strip the location prefix before forwarding to the backend. For example, a request to `/fitness/api/health` is forwarded to the backend as `/api/health`.

### Correct NGINX config block

```nginx
location /fitness/ {
    proxy_pass http://fitness-tracker:5000/;
    proxy_http_version 1.1;
    add_header X-Upstream fitness-tracker;
}
```

### Why the trailing slash must never be removed

Removing the trailing slash causes NGINX to forward the full path including the location prefix (`/fitness/api/health`) to the backend. The backend has no route for that path and returns a 404. This is a silent misconfiguration — the container starts and NGINX responds, but every request fails.

This pattern applies to every service in the NGINX routing table.

### WARNING: Location blocks must exist in BOTH NGINX config files

> **CRITICAL: Every service location block must exist in BOTH nginx config files**

The InternalWebServer repo has two separate NGINX server blocks in two separate files:

- `nginx/conf.d/prod.conf` — handles `mitchellnet.local` (hostname-based access)
- `nginx/conf.d/000-bareip.conf` — handles `192.168.2.10` (IP-based access)

When adding a new service location block (e.g. `/fitness/`, `/api/bench/`), it must be added to **both** files. If it is only added to `prod.conf`, the service will work via `mitchellnet.local` but return 404 via the IP address — and vice versa. This mistake is not obvious and is very hard to debug because NGINX, Flask, and the deploy pipeline all appear correct.

Any time a new service is onboarded via `aaNewService` or manually, verify both files contain the location block before closing the task.

---

## NGINX TLS and Security Header Hardening (Phase 0, Item 6)

**Date completed:** 2026-06-13  
**Repo changed:** InternalWebServer

This phase added TLS hardening and HTTP security headers to the NGINX reverse proxy. The changes apply to all server blocks in both `prod.conf` and `000-bareip.conf`.

### New files

| File | Purpose |
| --- | --- |
| `nginx/nginx.conf` | Overrides the stock image default; adds `server_tokens off` |
| `nginx/conf.d/ssl-params.conf` | TLS hardening: TLSv1.2+ only, strong cipher suite, session config |
| `nginx/conf.d/security-headers.conf` | Five security headers, included in every `location {}` block |

### Files modified

- `nginx/conf.d/prod.conf` — added `include conf.d/ssl-params.conf;` in the SSL server block; added `include conf.d/security-headers.conf;` in every `location {}` block
- `nginx/conf.d/000-bareip.conf` — same changes as `prod.conf`
- `docker-compose.yml` — added volume mount to inject the custom `nginx/nginx.conf` into the container

### Security headers applied

| Header | Value |
| --- | --- |
| `Strict-Transport-Security` | `max-age=63072000` |
| `X-Frame-Options` | `SAMEORIGIN` |
| `X-Content-Type-Options` | `nosniff` |
| `Referrer-Policy` | `no-referrer-when-downgrade` |
| `Permissions-Policy` | `geolocation=(), microphone=(), camera=()` |

TLS 1.0 and 1.1 are disabled. Only TLS 1.2 and 1.3 are accepted.

Content-Security-Policy (CSP) was intentionally omitted — it needs per-site tuning due to SSI, multiple upstreams, and inline scripts.

### WARNING: add_header does NOT inherit from parent blocks

> **CRITICAL: `add_header` directives do not inherit from parent blocks if the child block contains any `add_header` of its own.**

In NGINX, if a `location {}` block contains any `add_header` directive, all `add_header` directives from the enclosing `server {}` or `http {}` block are silently ignored for that location. Headers set at a higher level are completely dropped.

**Solution:** Include security headers explicitly in every `location {}` block via a shared include file:

```nginx
location /fitness/ {
    proxy_pass http://fitness-tracker:5000/;
    proxy_http_version 1.1;
    include conf.d/security-headers.conf;
}
```

This pattern must be followed for every `location {}` block in both `prod.conf` and `000-bareip.conf`. Missing one block means that location sends no security headers at all — no error is logged and the headers silently disappear.

---

## Stop Leaking Error Detail (Phase 0, Item 7)

**Date completed:** 2026-06-13  
**Repos changed:** InternalWebServer, fitness-tracker, bench-instrument-service

This phase eliminated error responses that leaked internal implementation detail — NGINX version strings, raw exception messages, database error text, and internal hostnames — from all services that face the network.

### InternalWebServer

- The `nginx-prod` container now mounts the same custom `nginx/nginx.conf` as `nginx-proxy`, so `server_tokens off` applies to both containers. The NGINX version number no longer appears in error pages from either container.

### fitness-tracker

- Added global Flask error handlers for 400, 404, 405, and 500 in `app/app.py`. All return a clean JSON body (`{"error": "..."}`) instead of the default Werkzeug HTML error pages.
- Replaced all `'error': str(e)` patterns in `app/routes/api_routes.py` with `'error': 'Internal server error'`. Raw exception text — including database errors and stack traces — is no longer returned to clients.
- Added server-side exception logging to `app/routes/api_routes.py`. Exceptions are now recorded with full traceback via `logger.error(..., exc_info=True)`.

### bench-instrument-service

- In `app/dependencies.py`, suppressed three error responses that leaked internal detail: instrument driver names, instrument IP addresses, and raw exception strings. All three now return the generic message `"Instrument unavailable"` to the client and log the real detail server-side.

---

## Monitoring/SNMP Hardening (Phase 0, Item 8)

**Date completed:** 2026-06-14  
**Config files:** `~/network-monitoring/` and `~/monitoring/` on InternalWebServer (to be captured in git under Item 17 — mitchellnet-monitoring repo)

### Changes made

**Port binding**  
All monitoring ports are now bound to `127.0.0.1` so they are not reachable from the network:

| Service | Port |
| --- | --- |
| Prometheus | 9090 |
| Grafana | 3000 |
| Node Exporter | 9100 |
| Blackbox Exporter | 9115 |
| InfluxDB | 8086 |

**Credential rotation**  
Grafana and InfluxDB credentials were rotated and are stored in `~/web_server/.env` on the server. They are not in version control.

**Orphan container removed**  
The `snmp-exporter` container had no running scrape config pointing at it and was removed.

**Blackbox scrape target fix**  
The blackbox scrape target was corrected to use container DNS (service name) rather than a bare IP, so it resolves correctly inside the Docker network.

### Note on git capture

The live config files for the monitoring stack (`~/network-monitoring/` and `~/monitoring/`) exist only on the server. They will be committed to a dedicated `mitchellnet-monitoring` repository as part of Item 17.
