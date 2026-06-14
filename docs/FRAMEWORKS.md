# MitchellNET Framework Guide: Flask vs FastAPI

**Last updated:** June 2026  
**Scope:** Python web frameworks used across MitchellNET services

---

## Current Framework Usage

| Service | Framework | Why |
|---|---|---|
| `fitness-tracker` | Flask | Simple CRUD (Create, Read, Update, Delete) app with HTML frontend; chosen when the app was first built for minimal complexity |
| `bench-instrument-service` | FastAPI | Instrument control API requiring async support, automatic OpenAPI docs, and strict request/response validation |
| `mitchellnet-device-registry` | FastAPI | New build; follows the FastAPI standard established by BIS |

---

## Why Two Frameworks?

MitchellNET has two frameworks because the services were built at different times for different purposes, not because two frameworks are inherently better than one.

**fitness-tracker** was the first MitchellNET Python service. Flask was the right choice at the time: it is simple, well-understood, and has no opinions about structure. For a small CRUD app with a self-contained HTML frontend, Flask's minimal footprint is a genuine advantage.

**bench-instrument-service** was designed from scratch with a full API contract, four instrument drivers, a session management system, and a comprehensive test suite. FastAPI's automatic OpenAPI documentation (`/docs`), request validation via Pydantic models, and native async support made it the correct tool for that scope of work.

There is no plan to migrate fitness-tracker to FastAPI. The cost of migration outweighs any benefit for a small, stable, working app. Both frameworks will coexist indefinitely.

---

## Flask — fitness-tracker

### What it is
Flask is a lightweight WSGI (Web Server Gateway Interface) web framework. It provides routing, request handling, and response generation with minimal built-in structure. Everything else — validation, serialisation, documentation — is added by the developer.

### How fitness-tracker uses it
```
app/
├── app.py              # Flask app init, blueprint registration, static file serving
├── routes/
│   └── api_routes.py   # All API endpoints as a Blueprint
└── config/
    └── database.py     # MariaDB connection helpers
```

- Routes are decorated with `@api_bp.route('/path', methods=['GET'])`
- Request data is read from `flask.request`; responses are `flask.jsonify()`
- A `require_api_key` decorator wraps protected endpoints
- The Flask app also serves the frontend HTML — `send_from_directory('frontend', 'index.html')` for static files, with server-side API key injection for `index.html` and `admin.html`
- CORS handled by `flask-cors`

### Strengths for this use case
- Simple, readable route definitions
- No boilerplate for a small CRUD API
- Easy to serve both the API and the frontend HTML from the same process
- Minimal learning curve

### Limitations
- No automatic request validation — invalid input must be caught manually
- No automatic API documentation
- Synchronous by default (WSGI, not ASGI) — fine for low-concurrency internal use
- No built-in data modelling

---

## FastAPI — bench-instrument-service

### What it is
FastAPI is a modern ASGI (Asynchronous Server Gateway Interface) web framework built on Starlette and Pydantic. It generates OpenAPI documentation automatically, validates request and response data against Pydantic models, and supports native async/await.

### How BIS uses it
```
app/
├── main.py             # FastAPI app init, router registration, lifespan handler
├── dependencies.py     # Shared dependency injection: registry, session, API key auth
├── config.py           # Pydantic settings loaded from BIS_* env vars
├── routers/            # One file per instrument + health + sessions
│   ├── health.py
│   ├── instruments.py
│   ├── sessions.py
│   ├── oscilloscope.py
│   ├── signal_generator.py
│   ├── multimeter.py
│   └── power_supply.py
├── models/             # Pydantic request/response models
└── drivers/            # Low-level SCPI instrument drivers
```

- Routes are decorated with `@router.get('/path', response_model=SomeModel)`
- Pydantic models enforce request and response structure — invalid input is automatically rejected with a 422 before the handler runs
- Dependencies are injected via `Depends()` — auth, registry access, and session validation are all handled this way
- Auth is applied at the router level: `app.include_router(instruments.router, dependencies=[Depends(verify_api_key)])` — one line protects every route in a router
- Settings are loaded via pydantic-settings with a `BIS_` prefix: `BIS_OSCILLOSCOPE_IP`, `BIS_LOG_LEVEL`, etc.
- OpenAPI docs available at `https://mitchellnet.local/api/bench/docs`

### Strengths for this use case
- Automatic `/docs` endpoint — invaluable when developing against real instruments
- Request validation catches bad input before it reaches instrument drivers
- `Depends()` injection makes it trivial to apply auth, session checks, and registry access consistently across all routes
- Response models ensure the API contract is always honoured
- Async support handles concurrent instrument polling without blocking

### Limitations
- More boilerplate than Flask for simple CRUD
- Pydantic model definitions add overhead for small, simple APIs
- Slightly steeper learning curve

---

## API Authentication: How Each Framework Handles It

Both services use the same mechanism — `X-API-Key` header checked against the `API_KEY` environment variable — but the implementation differs by framework.

### Flask (fitness-tracker)

A decorator pattern:

```python
def require_api_key(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        key = request.headers.get('X-API-Key', '')
        expected = os.environ.get('API_KEY', '')
        if not expected:
            return jsonify({'error': 'Server misconfiguration'}), 500
        if not hmac.compare_digest(key, expected):
            return jsonify({'error': 'Unauthorized'}), 401
        return f(*args, **kwargs)
    return decorated

# Applied per-route:
@api_bp.route('/activities')
@require_api_key
def get_activities():
    ...
```

`/api/health` is the only unprotected endpoint.

### FastAPI (bench-instrument-service)

A dependency injection pattern:

```python
_api_key_header = APIKeyHeader(name="X-API-Key", auto_error=False)

def verify_api_key(api_key: str = Security(_api_key_header)) -> None:
    expected = os.environ.get("API_KEY", "")
    if not expected:
        raise HTTPException(status_code=500, detail="Server misconfiguration")
    if not api_key or not hmac.compare_digest(api_key, expected):
        raise HTTPException(status_code=401, detail="Unauthorized")

# Applied at router registration — one line protects all routes in a router:
_auth = [Depends(verify_api_key)]
app.include_router(instruments.router, dependencies=_auth)
app.include_router(oscilloscope.router, dependencies=_auth)
# etc.

# Health router registered without _auth — unprotected:
app.include_router(health.router)
```

The FastAPI approach is more powerful: adding a new router automatically inherits auth by including it in the `_auth` list. In Flask, every new route must explicitly add the `@require_api_key` decorator.

---

## Choosing a Framework for Future Services

Use this decision guide for every new MitchellNET Python service:

```
Is this a new service?
│
├── Does it need to control hardware, call external APIs, or handle
│   concurrent connections without blocking?
│   └── YES → FastAPI (async support, Pydantic validation)
│
├── Will it have a formal API contract with multiple consumers,
│   or do you want automatic OpenAPI docs?
│   └── YES → FastAPI
│
├── Is it a simple CRUD API with a self-contained HTML frontend,
│   no concurrency requirements, and minimal external dependencies?
│   └── YES → Flask is acceptable, but FastAPI is still fine
│
└── Default → FastAPI
```

**In practice: default to FastAPI for all new MitchellNET services.**

Flask remains appropriate only for maintaining fitness-tracker. All new services — mitchellnet-device-registry, any future IoT ingestion service, any future dashboard backend — should use FastAPI. The slightly higher boilerplate cost is paid back immediately through automatic docs, validation, and the cleaner dependency injection model.

---

## Key Differences Quick Reference

| Feature | Flask | FastAPI |
|---|---|---|
| Framework type | WSGI (synchronous) | ASGI (async-capable) |
| Request validation | Manual | Automatic via Pydantic |
| Response validation | Manual | Automatic via Pydantic |
| OpenAPI docs | Plugin required | Built-in at `/docs` |
| Auth pattern | Decorator per route | Depends() at router level |
| Settings/config | Manual env reads | pydantic-settings |
| Learning curve | Low | Medium |
| Boilerplate | Minimal | Moderate |
| MitchellNET usage | fitness-tracker (maintain only) | BIS, device-registry, all future |

---

## See Also

- [ARCHITECTURE.md](ARCHITECTURE.md) — full system design including service inventory and roadmap
- [bench-instrument-service/docs/ARCHITECTURE.md](../../bench-instrument-service/docs/ARCHITECTURE.md) — BIS-specific design
- [bench-instrument-service/docs/BIS_Implementation_Blueprint.md](../../bench-instrument-service/docs/BIS_Implementation_Blueprint.md) — full BIS implementation reference
- fitness-tracker README — service overview and deployment guide
