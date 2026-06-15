# MitchellNET Service Types

**Last updated:** June 2026  
**Scope:** Supported scaffold types for new MitchellNET services

---

## Overview

Every MitchellNET service is created using `aaNewService <repo-name> --type <type>`. The script
scaffolds the repo from a template in `compose/templates/<type>/`, covering the Dockerfile,
docker-compose.yml, GitHub Actions workflow, .env.example, and .gitignore.

This document defines the four supported types, the excluded types and the reasoning behind
each exclusion, and the conditions under which an excluded type should be reconsidered.

See [FRAMEWORKS.md](FRAMEWORKS.md) for the Flask vs FastAPI decision guide.  
See [ARCHITECTURE.md](ARCHITECTURE.md) for the full service inventory and Docker networking rules.

---

## Supported Service Types

### 1. `python-fastapi`

**Use for:** Any new MitchellNET Python service that exposes an API, controls hardware, or
has concurrency requirements.

**Stack:** Python 3.12, FastAPI, Uvicorn, no database.

**When to choose this:**
- New API service with no relational database requirement
- Hardware control (instruments, IoT ingestion, device registry)
- Service needs automatic OpenAPI docs at `/docs`
- Concurrent connections or async I/O required

**Real examples:** `bench-instrument-service`, `mitchellnet-device-registry`

**Template:** `compose/templates/python-fastapi/`

---

### 2. `python-flask`

**Use for:** Maintaining `fitness-tracker` only, or a future simple CRUD service with a
self-contained HTML frontend and no concurrency requirements.

**Stack:** Python 3.12, Flask, Gunicorn, no database.

**When to choose this:**
- Maintaining existing Flask service (fitness-tracker)
- New service is a simple CRUD app with self-contained HTML frontend
- No async requirements, no formal API contract

**Default to `python-fastapi` instead** — Flask is acceptable here but FastAPI is always fine.
See [FRAMEWORKS.md](FRAMEWORKS.md) for the full decision guide.

**Real examples:** `fitness-tracker` (no-DB variant)

**Template:** `compose/templates/python-flask/`

---

### 3. `python-flask-db`

**Use for:** A Flask service that requires a MariaDB sidecar. Mirrors the fitness-tracker
architecture exactly.

**Stack:** Python 3.12, Flask, Gunicorn, MariaDB 10.11.

**When to choose this:**
- All conditions for `python-flask` apply, plus
- Service requires a relational database

**Architecture note:** MariaDB runs on an internal-only Docker network, never exposed to
the `mitchellnet` network. Only the Flask app container joins both networks. See
[ARCHITECTURE.md §4](ARCHITECTURE.md#4-docker-networking) for the dual-network pattern.

**Real examples:** `fitness-tracker`

**Template:** `compose/templates/python-flask-db/`

---

### 4. `static-nginx`

**Use for:** A service that serves only static files — HTML, CSS, JavaScript, images. No
application server, no backend API.

**Stack:** NGINX Alpine, static files only.

**When to choose this:**
- Pure frontend: documentation site, status page, landing page
- No server-side logic required
- Files are committed directly to the repo (no build step)

**Note:** If the static site requires a build step (React, Vue, Vite), use the excluded
`node-static` type below when it is added. Do not attempt to bolt a Node build step onto
this template.

**Template:** `compose/templates/static-nginx/`

---

## Excluded Service Types

These types were evaluated and deliberately excluded from the initial supported set. The
reasoning is documented here so that future planning decisions are informed by what was
considered, not just what was chosen.

---

### `node-express`

**What it is:** A Node.js service using Express (or Fastify/Hono) as an API server.

**Why excluded:**
- No existing MitchellNET service uses Node as a server-side runtime
- Python (FastAPI) covers all current and planned API needs with less context-switching
- Introducing a second backend language adds operational complexity for a solo operator
- No imminent use case justifies the addition

**When to reconsider:**
- A service requires WebSockets or Server-Sent Events for real-time push to a browser
  (FastAPI supports this too, but Node's ecosystem is more mature for this pattern)
- A future service is built primarily in JavaScript/TypeScript for other reasons and a
  Node backend avoids a language boundary
- A React/Vue frontend requires a lightweight BFF (Backend for Frontend) layer

---

### `node-static`

**What it is:** A static site with a Node-based build step (Vite, esbuild, Parcel). The
build produces static files; NGINX serves them. The container runs the build during image
construction.

**Why excluded:**
- No current MitchellNET frontend uses a JavaScript build tool
- All existing frontends are vanilla HTML/CSS/JS committed directly to the repo
- Adds Node.js and npm to the Docker build layer for no current benefit

**When to reconsider:**
- A new service frontend is built with React, Vue, Svelte, or any framework requiring a
  build step
- `static-nginx` is chosen and then outgrows vanilla HTML — migrate to this type at that point

---

### `vaultwarden` / third-party image

**What it is:** A service built entirely from an upstream Docker image with no custom
application code — just a `docker-compose.yml` pulling a pre-built image.

**Why excluded:**
- Not a repeatable pattern — each third-party service has unique configuration requirements
- A template would add no value over reading the upstream project's own documentation
- Vaultwarden (Item 14) is the only planned instance and is a one-off

**When to reconsider:** Never as a template type. Third-party services get their own repo
with a hand-authored `docker-compose.yml` and documentation.

---

### `go` / `rust`

**What it is:** Services written in Go or Rust.

**Why excluded:**
- No MitchellNET service uses either language
- No planned service has performance requirements that would justify either language over Python
- Adds language toolchain complexity for a solo operator with no current Go/Rust experience
  in this stack

**When to reconsider:**
- A service has demonstrated performance constraints that Python cannot meet
- Operator has sufficient Go/Rust experience to maintain the service long-term

---

### `mqtt-bridge`

**What it is:** A lightweight service whose primary role is subscribing to MQTT topics and
forwarding data to another service or database.

**Why excluded:**
- One planned instance only (`mitchellnet-iot` MQTT ingestion)
- The pattern is simple enough to hand-author without a template
- MQTT ingestion logic in `mitchellnet-device-registry` is embedded in the FastAPI service
  rather than being a separate process — use `python-fastapi` for this pattern

**When to reconsider:**
- A dedicated MQTT bridge service is needed that is separate from any API service
- Multiple MQTT bridge services are planned, making a template worthwhile

---

## Adding a New Service Type

When a new type is added:

1. Create the template directory at `compose/templates/<type>/`
2. Add a section to this document under **Supported Service Types**
3. Move the relevant entry from **Excluded Service Types** to **Supported Service Types**
   (or add a new entry if it was not previously excluded)
4. Update `scripts/aaNewService` — add the new type to the `case` statement and the usage
   help text
5. Update [ARCHITECTURE.md §3](ARCHITECTURE.md#3-script-strategy) script strategy table
6. Commit via `aaGitPromote` with a message referencing this document
