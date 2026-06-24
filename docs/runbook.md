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

5. Add MitchellNET subdomains to `/etc/hosts`:

   ```bash
   echo "192.168.2.10 vault.mitchellnet.local" | sudo tee -a /etc/hosts
   ```

   Repeat for any other subdomains as new services are added.

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
6. Verify the recipes DB backup cron job was installed by bootstrap:

   ```bash
   crontab -l
   # Should show: 0 2 * * * /home/andrew/backups/recipes/backup_recipes_db.sh
   ~/backups/recipes/backup_recipes_db.sh
   cat ~/backups/recipes/backup.log
   ```

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

Certs are written to `ssl/certs/` (git-ignored).

### Subject Alternative Names (SANs)

As of 20 June 2026, the cert covers: `mitchellnet.local`, `*.mitchellnet.local`, `localhost`, `127.0.0.1`, and `192.168.2.10` (the bare IP). The bare-IP SAN was added that day specifically so `https://192.168.2.10/...` is trusted without a browser warning — see `InternalWebServer/docs/nginx-routing.md` § Bare-IP Parity Standard for why this matters.

If you ever need to add another SAN (e.g. a new subdomain), edit `ssl/generate.sh` — the SAN list is just the argument list passed to the `mkcert` command itself.

### Full generate → deploy lifecycle

`mkcert` is only installed on the Dev Mac — not on the server. The full path a regenerated cert must travel:

1. **Generate on the Dev Mac**, in `mitchellnet-infra`, on `main`:

   ```bash
   bash ssl/generate.sh
   ```

   This writes `mitchellnet.local+N.pem` and `mitchellnet.local+N-key.pem` to `ssl/certs/` (the `+N` suffix increments each time mkcert is re-run with a different SAN list — check `ls ssl/certs/` for the actual filename).

2. **Rename to the deploy convention** (also in `ssl/certs/`):

   ```bash
   cp mitchellnet.local+N.pem server.crt
   cp mitchellnet.local+N-key.pem server.key
   ```

   The live config and deploy tooling expect the fixed names `server.crt` / `server.key`, not the mkcert-generated filename.

3. **Back up the live cert on the server first** (so there's an instant rollback):

   ```bash
   ssh andrew@192.168.2.10
   mkdir -p ~/web_server/nginx/certs/backup
   cp ~/web_server/nginx/certs/server.crt ~/web_server/nginx/certs/backup/server.crt.bak-$(date +%Y%m%d)
   cp ~/web_server/nginx/certs/server.key ~/web_server/nginx/certs/backup/server.key.bak-$(date +%Y%m%d)
   ```

4. **Copy the new cert to the server** — from the Dev Mac:

   ```bash
   scp ssl/certs/server.crt andrew@192.168.2.10:~/web_server/nginx/certs/server.crt
   scp ssl/certs/server.key andrew@192.168.2.10:~/web_server/nginx/certs/server.key
   ```

   Note the destination: `/home/andrew/web_server/nginx/certs/` — this is a persistent, manually-maintained directory on the server, separate from any repo checkout. It is the actual host path Docker mounts into `nginx-proxy` (confirm with `docker inspect nginx-proxy --format '{{range .Mounts}}{{.Source}} -> {{.Destination}}{{"\n"}}{{end}}'`). It is **not** the same as `InternalWebServer/nginx/certs/` in any repo checkout (that path only contains a `.gitkeep` — certs are deliberately excluded from the repo and from CI deploys).

5. **Restart nginx-proxy** so it picks up the new cert:

   ```bash
   docker restart nginx-proxy
   ```

6. **Verify the live cert**, from the server (or any machine that can reach it):

   ```bash
   echo | openssl s_client -connect 192.168.2.10:443 -servername 192.168.2.10 2>/dev/null | openssl x509 -noout -text | grep -A2 "Subject Alternative Name"
   ```

   This performs a real TLS handshake and shows exactly what nginx is presenting to clients — the only fully trustworthy check, since it doesn't rely on assuming the right file ended up in the right place.

---

## Argon2 Token Escaping in Docker env_file

Docker Compose `env_file` interprets `$` as variable substitution. Argon2 PHC strings (used for Vaultwarden's `ADMIN_TOKEN`) contain multiple `$` characters and will be mangled if written literally.

**Fix:** escape all `$` as `$$` in the `.env` file:

```bash
# Generate hash
docker exec -it vaultwarden /vaultwarden hash --preset owasp

# Write to .env with $$ escaping
python3 << 'EOF'
hash = '$argon2id$v=19$m=19456,...'  # paste your full hash here
escaped = hash.replace('$', '$$')
content = f'ADMIN_TOKEN={escaped}\n'
print(content)  # verify, then write to .env
EOF
```

Docker automatically unescapes `$$` back to `$` when injecting into the container environment.

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

### Exception: services with multiple NGINX entry points

Some Flask apps are accessible via more than one NGINX location prefix. The recipes app, for example, is reachable at `/recipes/`, `/meal-plan/`, and `/shopping-list/` — all served by the same container.

For the **primary prefix** (`/recipes/`), use Approach A as normal — trailing slash strips the prefix:

```nginx
location /recipes/ {
    proxy_pass http://recipes-app:5000/;
}
```

For **secondary prefixes** (`/meal-plan/`, `/shopping-list/`), do NOT use a trailing slash on `proxy_pass`. Instead, omit the path entirely so NGINX forwards the full path unchanged to Flask:

```nginx
location /meal-plan/ {
    proxy_pass http://recipes-app:5000;
}

location /shopping-list/ {
    proxy_pass http://recipes-app:5000;
}
```

Flask then handles `/meal-plan/` and `/shopping-list/` directly as registered routes. The distinction:
- Trailing slash (`http://service:5000/`) → NGINX strips the location prefix before forwarding
- No path (`http://service:5000`) → NGINX forwards the full original path unchanged

### WARNING: Flask `url_for` generates prefix-unaware paths

Flask's `url_for()` generates paths relative to the Flask app's own route table — it has no knowledge of the NGINX prefix. For example, after saving a recipe, `url_for("recipes.detail", recipe_id=1)` generates `/1`, not `/recipes/1`. NGINX has no route for `/1` and returns 404.

**Fix:** Use hard-coded absolute paths for any redirect that must include the NGINX prefix:

```python
# WRONG — generates /1, NGINX 404s
return redirect(url_for("recipes.detail", recipe_id=r.id))

# CORRECT — generates /recipes/1, NGINX routes correctly
return redirect(f"/recipes/{r.id}")
```

This applies to all redirects after form saves, deletes, or any action that navigates away from the current prefix.

### WARNING: Flask templates must use HTML links, not Markdown

When generating HTML templates for Flask apps, always use HTML anchor tags. Markdown-style links render as plain text in browsers:

```html
<!-- WRONG — renders as literal text "[← Back](/recipes/)" -->
[← Back](/recipes/)

<!-- CORRECT -->
<a href="/recipes/">← Back</a>
```

This is particularly relevant when using AI tools to generate template code — they may produce Markdown link syntax instead of HTML.

### WARNING: Location blocks must exist in BOTH NGINX config files

> **CRITICAL: Every service location block must exist in BOTH nginx config files**

The InternalWebServer repo has two separate NGINX server blocks in two separate files:

- `nginx/conf.d/prod.conf` — handles `mitchellnet.local` (hostname-based access)
- `nginx/conf.d/000-bareip.conf` — handles `192.168.2.10` (IP-based access)

When adding a new service location block (e.g. `/fitness/`, `/api/bench/`), it must be added to **both** files. If it is only added to `prod.conf`, the service will work via `mitchellnet.local` but return 404 via the IP address — and vice versa. This mistake is not obvious and is very hard to debug because NGINX, Flask, and the deploy pipeline all appear correct.

This warning existed in the runbook before it actually happened in practice. BIS's `/api/bench/` block was added to `prod.conf` only on 15 June 2026 and never to `000-bareip.conf`, and the gap went unnoticed for 5 days until 20 June 2026 — proving that documentation alone doesn't prevent this class of mistake. As of 20 June 2026, `aaNewService`'s checklist explicitly lists both files by name (rather than the generic "add an NGINX location block" line it used before), so this is now backed by tooling, not just this paragraph. See `InternalWebServer/docs/nginx-routing.md` § Bare-IP Parity Standard for the full incident and the policy now in place.

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

---

## SSH Host-Key Verification (Phase 0, Item 9) + Cleanup partial (Item 10)

**Date completed:** 2026-06-15  
**Repo changed:** InternalWebServer (PR #152)

### Item 9 — SSH host-key verification

Audited all repos and the server for `StrictHostKeyChecking=no`. The only hit was `InternalWebServer/setup_ci_cd.sh` — a one-time bootstrap script written early in the project to scaffold the repo and generate the original workflow files. It was never called by CI or any other script, and the workflows it generated were long since replaced by the self-hosted runner pattern (`runs-on: self-hosted`). The live workflow (`deploy-prod.yml`) uses only local `rsync` and `docker` commands — no SSH to remote hosts.

**Fix:** Deleted `setup_ci_cd.sh`. No workflow files required changes.

### Item 10 — Cleanup (partial)

`html/prod/tmp.txt` (a zero-byte placeholder file) was deleted in the same PR.

---

## MitchellNET Header/Footer in Flask Apps (June 2026)

**Date completed:** 18 June 2026  
**Repos changed:** InternalWebServer, recipes

All Flask apps served through MitchellNET should display the shared MitchellNET header and footer for consistent navigation. The header and footer are maintained as a single source of truth in the `InternalWebServer` repo and served by `nginx-proxy`.

### How the include system works

The shared fragments live in `InternalWebServer/includes/`:

| File | Purpose |
| --- | --- |
| `includes/header.html` | MitchellNET nav bar (logo + Home/Engineering/Workspaces/Infrastructure/Projects/About) |
| `includes/footer.html` | Site footer (copyright line) |

The `InternalWebServer` deploy pipeline syncs `includes/` to `~/web_server/includes/` on the server. The `nginx-proxy` docker-compose mounts this directory and serves it at `/includes/`.

The static MitchellNET pages load the fragments via `includes.js` — a client-side JavaScript include system that fetches `/includes/header.html` and `/includes/footer.html` and injects them into placeholder `<div>` elements.

### Adding header/footer to a Flask app

In the app's Jinja2 `base.html` template:

1. Link the MitchellNET stylesheet in `<head>`:

   ```html
   <link rel="stylesheet" href="/css/style.css">
   ```

2. Add the env banner and header placeholder at the top of `<body>`:

   ```html
   <div id="env-banner" class="env-prod"></div>
   <div data-include="/includes/header.html"></div>
   ```

3. Add the footer placeholder and includes.js before `</body>`:

   ```html
   <div data-include="/includes/footer.html"></div>
   <script src="/js/includes.js" defer></script>
   ```

Do **not** add a custom `<nav>` block — the shared header replaces it entirely.

### Updating the nav

To change the navigation links or header content, edit `InternalWebServer/includes/header.html` and merge via PR. All apps pick up the change automatically on next page load — no changes required in individual app repos.

### curl and HEALTHCHECK requirement

All MitchellNET service Dockerfiles must install `curl` and define a `HEALTHCHECK`. Without `curl`, Docker's health check fails silently with `exec: "curl": executable file not found` and the container is permanently marked `unhealthy` even when the app is working correctly.

The `aaNewService` Dockerfile templates already include this. When maintaining older services, ensure the pattern is present:

```dockerfile
# Install system dependencies (curl required for Docker health check)
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:5000/ || exit 1
```

For `static-nginx` (alpine-based), use `wget` instead — it is built into alpine:

```dockerfile
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD wget -qO- http://localhost/ || exit 1
```

All Item 10 sub-tasks completed. See InternalWebServer PRs #152–#155 and bench-instrument-service PR #11.

---

## Incident Log

### 19–20 June 2026 — Unattended power-loss reboot

The server (`imac-server`) lost power and rebooted unattended sometime between **21:29 on 18 June** (last interactive SSH session) and **15:12 on 19 June** (next boot). Root cause was **not** identified — ruled out: scheduled OS reboot (`unattended-upgrades` `Automatic-Reboot` is `false`), GNOME idle/suspend (the system's own idle-suspend setting is `nothing`, i.e. disabled, and `suspend.target` is masked at the systemd level), and a clean shutdown (the previous boot's final log lines show routine cron activity with no shutdown sequence at all). This is the signature of an abrupt hardware/power-layer event — no UPS or power-loss monitoring (`apcupsd`, `nut-client`) is currently installed, so no further forensic detail is available.

**What worked correctly:** every container's `restart: unless-stopped`-equivalent policy functioned as designed — `docker ps` after the reboot showed every service `Up X minutes (healthy)` with no manual intervention required. The apparent "apps acting strange" symptom reported after this reboot was traced entirely to the pre-existing bare-IP routing/cert gap (see § Location Blocks warning above and `InternalWebServer/docs/nginx-routing.md`), not to any container or restart-policy failure.

**Open follow-up (not yet actioned):** consider a UPS for graceful shutdown on power loss, and/or installing `apcupsd`/`nut-client` so future power events leave a forensic trail instead of an unexplained gap in the logs.

### 20 June 2026 — Bare-IP routing and cert gap

`https://192.168.2.10/api/bench/` returned a plain nginx 404 while `https://mitchellnet.local/api/bench/` worked correctly. Root cause: `000-bareip.conf` never received the `/api/bench/` location block added to `prod.conf` on 15 June 2026, and separately the TLS cert had no SAN for `192.168.2.10`. Both fixed same-day:

- Cert regenerated with `192.168.2.10` added as a SAN (`mitchellnet-infra` PR #36)
- `/api/bench/` location block added to `000-bareip.conf` (`InternalWebServer` PR #167)
- `aaNewService` checklist updated to name both vhost files explicitly (`mitchellnet-infra` PR #37)
- `nginx-routing.md` fully audited and rewritten — see `InternalWebServer/docs/nginx-routing.md`

**Known residual issue (low priority, unresolved):** the bare-IP docs page (`https://192.168.2.10/api/bench/docs`) shows a browser "Not Secure" badge despite a confirmed valid, trusted certificate. Investigated and ruled out: BIS's own HTML/JSON, both CDN-hosted Swagger UI assets, and all requests in a captured page load — no `http://` fetch found anywhere. Root cause not identified; functionality unaffected.

---

## Recipes DB Backup

A nightly cron job dumps the `recipes_db` MariaDB database to the host filesystem and retains the last 3 dumps, automatically pruning older files to prevent disk fill.

### Files

- **Script:** `server-scripts/backup_recipes_db.sh` in `mitchellnet-infra` repo
- **Deployed to:** `~/backups/recipes/backup_recipes_db.sh` on the server
- **Dumps:** `~/backups/recipes/recipes_db_YYYY-MM-DD.sql`
- **Log:** `~/backups/recipes/backup.log`

### Cron schedule

Runs nightly at 02:00 server time. Installed automatically by `server-setup/bootstrap.sh`.
To verify:

```bash
crontab -l
```

### Manual run and verification

```bash
~/backups/recipes/backup_recipes_db.sh
cat ~/backups/recipes/backup.log
ls -lh ~/backups/recipes/*.sql
```

### Retention policy

Keeps the 3 most recent `.sql` files. Older files are pruned automatically at the end of each successful run.

### Restore procedure

To restore `recipes_db` from a dump file:

```bash
# 1. Copy the dump into the running container
docker cp ~/backups/recipes/recipes_db_YYYY-MM-DD.sql recipes-db:/tmp/restore.sql

# 2. Run the restore inside the container
docker exec -it recipes-db \
    bash -c 'mysql -uroot -p"$MYSQL_ROOT_PASSWORD" recipes_db < /tmp/restore.sql'

# 3. Verify the restore
docker exec -it recipes-db \
    mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SELECT COUNT(*) FROM recipes_db.recipes;"
```

### Future monitoring (Phase 3)

When the MitchellNET monitoring stack is built, add an SNMP trap or Grafana annotation on backup failure. The `TODO` comment in `backup_recipes_db.sh` marks the insertion point.
