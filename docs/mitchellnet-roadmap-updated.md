MitchellNET Roadmap — Full Picture
Last updated: 22 June 2026 (planning session — Cook Log / UC-15 specified; BRD + HLA updated to v1.2; recipes PR #4 item 6 still next)
Item 20 (RRSP/RRIF Withdrawal Planning app) added earlier — still pending build.

Completed
    • ✅ mitchellnet-infra — scripts, runbook, architecture docs
    • ✅ All repos on PR-based workflow with branch protection
    • ✅ bench-instrument-service — Phase 1, Phase 2, and Phase 3 complete (dashboard, bench_client.py, webhooks — 15 June 2026)
    • ✅ ContextVar cross-context bug — fixed & deployed
    • ✅ Fitness tracker extraction — live
    • ✅ Node 24 / checkout@v5 rollout — all repos done
    • ✅ Item 12: aaNewService template + SERVICE-TYPES.md + 4 compose templates — mitchellnet-infra PR #23 (15 June 2026)
    • ✅ Item 13: BIS Phase 3 — dashboard, bench_client.py, webhooks — BIS PRs #12–#16, mitchellnet-infra PR #25 (15 June 2026)
    • ✅ Item 14: Vaultwarden — live at https://vault.mitchellnet.local/ (16 June 2026)
    • ✅ Item 15: Recipes app — scaffold + full UI complete (17 June 2026) ◦ recipes repo created via aaNewService recipes --type python-flask-db ◦ Flask + MariaDB running at https://mitchellnet.local/recipes/ ◦ Full CI/CD pipeline: test → deploy → health check all passing ◦ PRs #1–#13: scaffold, core models, routes, meal plan, shopping list, HTML UI, NGINX routing fixes, template fixes, save redirect fix, README dev notes ◦ Browse, add, edit, delete, meal plan, shopping list all functional
    • ✅ mitchellnet-infra PR #30: Fix aaNewService template backlog items A–F (17 June 2026)
    • ✅ mitchellnet-infra PR #31: docs updated with NGINX multi-prefix exception, url_for warning, HTML template warning (17 June 2026)
    • ✅ InternalWebServer: nginx-routing.md Flask Service Routing Patterns section added (17 June 2026)
    • ✅ InternalWebServer website updates (17 June 2026): ◦ Recipes link fixed → /recipes/ ◦ Vaultwarden added to Infrastructure → Hosted Services card ◦ Workshop renamed to Workspaces (home page, hub page, nav header) ◦ Music Studio hub card added to Workspaces page ◦ README routing table updated with recipes entries
    • ✅ Anthropic API account created (17 June 2026): ◦ Account: Google login via va3wam@gmail.com at https://platform.claude.com ◦ $5 USD credits purchased (pay-as-you-go, separate from Claude.ai subscription) ◦ API key mitchellnet-recipes created and saved to Vaultwarden ◦ ANTHROPIC_API_KEY added to ~/services/recipes/.env on server
    • ✅ RRSP/RRIF Withdrawal Planning — analysis complete, documents produced (18 June 2026): ◦ Full financial model built: year-by-year simulation 2026–2084, Ontario tax engine, RRIF minimums, CPP/OAS deferral ◦ Pension income splitting optimised: $105,785 lifetime tax saving identified ◦ Mitchell_RRSP_Report.docx — full analysis with charts, income splitting tables, milestones ◦ Mitchell_RRSP_BRD.docx — 24 functional requirements for production web app ◦ Mitchell_RRSP_HLA.docx — proposed architecture (NOTE: review against existing MitchellNET stack before build) ◦ Item 20 added to Feature/Build Work table for production build
    • ✅ 18 June 2026 session — recipes PR #3 (Claude API import) completed and hardened: ◦ recipes PR #16 — Claude API recipe import (URL fetch + document upload) merged, deployed, CI green ◦ Implemented: services/fetcher.py (URL fetch + HTML clean), services/extractor.py (Claude extraction, text + document), services/categorizer.py (ingredient categorization — has a known bug, see below), routes/import_.py (GET /import, POST /import/url, POST /import/upload, POST /import/save), templates import/import.html + import/review.html ◦ recipes PR #17 — fixed Claude max_tokens 1000 → 4096 (was truncating JSON on recipes with many ingredients) — merged, deployed, CI green ◦ Live functional test successful: imported "Garlic Prawns (Shrimp)" from RecipeTin Eats — name, cuisine, protein, prep/cook time, notes, ingredients, steps all extracted correctly and saved ◦ recipes PR #18 — BRD and HLA updated to v1.1 (UC-11 through UC-14 added, prep_ahead data model, lessons learned section) — merged, CI green ◦ KNOWN BUG (not yet fixed): app/services/categorizer.py calls extractor.call_claude(), which uses the recipe-extraction system prompt instead of a categorization-specific prompt. All ingredients are currently categorized as "Other". Fix is scoped into PR #4 (see below). ◦ Test recipe records (test, test, test3, test4) still in production DB — cleanup not yet done, low priority
    • ✅ 20 June 2026 session — Bare-IP routing & cert parity fixed (BIS triage that turned into a full infra audit): ◦ Symptom: BIS unreachable via https://192.168.2.10/api/bench/ (plain nginx 404), worked fine via mitchellnet.local ◦ Root cause #1: /api/bench/ location block was added to prod.conf on 15 June but never mirrored to 000-bareip.conf ◦ Root cause #2: self-signed TLS cert had no SAN for 192.168.2.10, so bare-IP HTTPS always warned regardless of routing ◦ mitchellnet-infra PR #36 — cert regenerated with 192.168.2.10 added as a SAN; bare-IP HTTPS now fully trusted ◦ InternalWebServer PR #167 — /api/bench/ added to 000-bareip.conf; bare-IP and mitchellnet.local now in full path-for-path parity ◦ mitchellnet-infra PR #37 — aaNewService checklist updated to explicitly name both NGINX vhost files (prod.conf and 000-bareip.conf) instead of a generic one-liner, so this class of gap is now caught by tooling, not just documentation ◦ InternalWebServer PR #168 — nginx-routing.md fully audited and rewritten: corrected several already-stale entries (a documented /api/ block that no longer existed, missing /fitness/ /recipes/ /meal-plan/ /shopping-list/ blocks, the Vaultwarden subdomain vhost was undocumented entirely), added a "Bare-IP Parity Standard" section defining the policy (Vaultwarden's subdomain vhost is explicitly exempt — no bare-IP equivalent of a subdomain) ◦ mitchellnet-infra PR #38 — runbook.md expanded with the full cert generate → rename → backup → scp → restart → verify lifecycle, plus a new "Incident Log" section ◦ mitchellnet-infra PR #39 — fixed a small cosmetic bug in ssl/generate.sh (trailing ls used the wrong relative path) ◦ Separately diagnosed: the underlying server reboot (18→19 June) that started this investigation was an unattended power-loss event, cause undetermined — ruled out scheduled OS reboot, GNOME suspend (masked at systemd level), and clean shutdown. All container restart policies worked correctly with no manual intervention needed; no UPS currently installed (open follow-up, not actioned) ◦ KNOWN ISSUE (low priority, logged, unresolved): https://192.168.2.10/api/bench/docs shows a browser "Not Secure" badge despite a confirmed valid, trusted cert — investigated thoroughly (BIS's own HTML/JSON, both CDN-hosted Swagger UI assets, full captured network request list), no http:// resource found anywhere, root cause not identified, functionality unaffected. See mitchellnet-infra/docs/runbook.md § Incident Log for full detail on both items.
    • ✅ 20 June 2026 evening session — recipes PR #4, Part 1 (5 of 7 scoped items shipped, one-PR-per-item, each merged and deploy-verified individually): ◦ recipes PR #19 — fixed categorizer.py bug: it was calling extractor.call_claude() and silently inheriting the recipe-extraction system prompt instead of its own categorization prompt (root cause of all ingredients showing "Other"). Gave categorizer.py its own direct Anthropic API call via a shared get_client() helper exposed from extractor.py, with its own system prompt. Merged, deployed, verified. ◦ recipes PR #20 — loading indicator ("Extracting recipe…") added to both URL-import and file-upload forms on import.html: spinner overlay + submit-button disable on native form submit, no route changes needed. Merged, deployed, verified (Deploy to Production succeeded in 1m 39s). ◦ recipes PR #21 — loading indicator ("Saving…") added to the save form on review.html, same overlay pattern, distinct element IDs from PR #20's overlay to avoid any future template-merge collisions. Merged, deployed, verified (1m 23s). ◦ recipes PR #22 — delete button added to the browse page actions column, with a confirm() dialog naming the recipe and warning about cascade (ingredients, steps, cook log history). No backend changes needed — the /<id>/delete route and cascade="all, delete-orphan" relationships on Ingredient/Step/CookLog already existed and worked correctly once wired up from the UI. Merged, deployed, verified (1m 27s). ◦ recipes PR #23 — duplicate detection at import: new _find_duplicate() helper in routes/import_.py using difflib.SequenceMatcher (case-insensitive, threshold 0.8 — exact matches score 1.0 and are automatically caught by the same check, so no separate exact-match code path was needed); wired into both import_url and import_upload right before the review page renders; amber warning banner added to review.html with a "View Existing Recipe" link (opens in a new tab so the in-progress review form isn't lost) when a match is found; does not block save. Merged, deployed, verified (1m 36s). Live-tested successfully against the existing "Garlic Prawns (Shrimp)" recipe — banner appeared correctly with exact-match name; the resulting duplicate review was discarded, not saved. ◦ Deploy Verification step (per Standing Instructions) was checked via the Actions tab after every merge this session, not just assumed from the GitHub merge screen — this caught that the merge screen's "X checks pending" badge lags behind the actual Actions run completing, so the Actions tab itself remains the authoritative check. ◦ NEW KNOWN ISSUE (logged, not yet actioned): importing https://www.allrecipes.com/... fails with a 403 Forbidden from services/fetcher.py — confirmed via container logs (docker compose logs recipes-app) that AllRecipes is blocking the fetch (likely scraper/bot detection), not a code defect introduced this session. RecipeTin Eats and other previously-tested sources are unaffected. Root cause not yet narrowed down to a specific header (e.g. User-Agent) — out of scope for PR #4's locked decisions; would be its own small PR if pursued. ◦ NEW KNOWN ISSUE (logged, not yet actioned, not urgent): GitHub Actions surfaced a deprecation annotation this session — "Node.js 20 is deprecated... actions/setup-python@v5" being forced onto Node.js 24. Not a failure, every run this session still succeeded; flagged for a future mitchellnet-infra maintenance pass to bump the pinned action version. ◦ STILL OUTSTANDING from PR #4's original 7-item scope: item 4 (wishlist → rating system) remains DEFERRED per the locked design decision; item 6 (prep-ahead flag, needs a DB migration for prep_ahead + prep_ahead_override columns) was not started this session — see Resume Prompt below.
    • ✅ 20 June 2026 evening session — recipe data migration, first pass (44 of 48 recipes imported from the recovered old static list): ◦ Source list recovered from InternalWebServer's orphaned static page (html/prod/recipes/recipes.html — file was never deleted, just unlinked from nav when the Flask app went live 17 June; one commit in its whole history, 8a189d2) ◦ 44 of 48 URLs imported successfully across one user-driven import session ◦ porkStroganoff.pdf (the one local-file recipe on the old list) hit the 413 upload-size issue (see § 6.5) — worked around by rasterizing to a compressed JPEG (~290KB), imported successfully that way ◦ 4 URLs discarded, no further action: AllRecipes (403, known bot-block), AgingLikeWine (404, dead link), Yummly (redirects to kitchenaid.com, then times out — Yummly may no longer operate as a standalone recipe site, unconfirmed), FoodNetwork.ca (SSL handshake error talking to their server) ◦ Open follow-up (Andrew's own): the InsanelyGoodRecipes.com import (https://insanelygoodrecipes.com/vietnamese-recipes/) looks like a category/listing-page URL rather than a single recipe — needs a check of the saved recipe's detail page to confirm Claude extracted one real recipe, not garbled listing content ◦ Remaining: 6 cookbook page references (Nagi cookbook + New Nagi cookbook) still need manual "Add Recipe" entry since they have no URL

    • ✅ 22 June 2026 planning session — Cook Log / UC-15 specified and docs updated: ◦ New business requirement: track each time a recipe is made; user confirms they are making the dish and can optionally rate it 1–5 and add per-cook notes ◦ Design decisions locked: rating is optional at time of logging (can be added/edited later); "We made this!" button lives on both the detail page and the browse page (per-recipe row); each cook entry supports an optional free-text notes field; detail page shows summary (times made · avg rating · last made) at the top and full cook log (reverse chronological) below; individual entries are editable and deletable ◦ BRD updated to v1.2: UC-08 rewritten to reflect button-on-both-pages + immediate entry creation; UC-15 Cook Log added (full acceptance criteria for summary, full log, edit, delete, browse page button + summary); UC-02 updated; success criteria updated ◦ HLA updated to v1.2: cook_log.py route file added; cook_log/edit.html template added; new § 6.6 Cook Log Routes documents the four routes (POST /recipes/<id>/cook, GET+POST /cook-log/<log_id>/edit, POST /cook-log/<log_id>/delete), detail page summary block spec, full log table spec, browse page summary, and cook_summary property helper; PR table updated ◦ No new DB migration needed — cook_logs table already present in live schema ◦ Migration approach confirmed: Flask-Migrate (Alembic) — migrations/ directory exists in the repo ◦ Roadmap moved to mitchellnet-infra/docs/ as its permanent home

Feature/Build Work — Recipes App PR #4 (IN PROGRESS — 5 of 7 items shipped 20 June evening session; item 6 is the remaining blocker before this scope closes)
Scope agreed at end of 18 June 2026 session, design decisions locked in:
    1. ✅ DONE (recipes PR #20) — Loading indicator while importing from URL ("Extracting recipe…")
    2. ✅ DONE (recipes PR #21) — Loading indicator while saving a recipe ("Saving…")
    3. ✅ DONE (recipes PR #22) — Delete button for recipes on the browse page (with confirmation, cascade delete)
    4. DEFERRED (no change this session) — Replace wishlist boolean with a 1–5 rating system. Decision: need to see CookLog rating in action first before deciding whether recipe-level rating is a separate field or derived from CookLog average. Wishlist stays as-is for now.
    5. ✅ DONE (recipes PR #23) — Duplicate detection at import time: exact name match (case-insensitive) + fuzzy match via difflib.SequenceMatcher (threshold 0.8). Checked server-side when review page renders, before save. Warning shown with link to existing recipe; user can save anyway or discard. Does not block save. Live-verified against "Garlic Prawns (Shrimp)".
    6. ⏳ NOT STARTED — Prep-ahead flag (overnight marinating, dough resting, etc.) — design locked: Claude attempts to detect during extraction and sets prep_ahead in the JSON schema; user can manually override via prep_ahead_override column on review form and edit form. Needs a DB migration — migration approach/tooling for this repo not yet confirmed (no migrations/ directory found as of 18 June scaffold; likely raw SQL against database/init.sql plus an ALTER TABLE applied directly, to be confirmed at start of next session).
    7. ✅ DONE (recipes PR #19) — Bundled in ahead of the rest of PR #4: fixed categorizer.py bug — it now has its own direct Anthropic API call with its own system prompt instead of reusing extractor.call_claude().

BRD/HLA already updated for this scope and for UC-15 Cook Log (v1.2, 22 June 2026):
    • UC-11 Duplicate Detection at Import
    • UC-12 Prep-Ahead Flag
    • UC-13 Loading Indicators During AI Operations
    • UC-14 Delete Recipe
    • UC-15 Cook Log (22 June 2026) — see separate Cook Log PR #5 scope below
    • HLA data model: prep_ahead BOOLEAN, prep_ahead_override BOOLEAN added to recipes table (migration needed — not yet created); cook_logs table already present, no migration needed for UC-15
    • HLA section 6.4 Duplicate Detection — Python-only, no Claude call
    • HLA section 6.6 Cook Log Routes — four routes, detail page summary + full log spec, browse page button + summary, cook_summary property
    • HLA section 10 Lessons Learned — max_tokens sizing, don't share Claude call functions across different system prompts, curl -k for self-signed cert smoke tests

Files already touched for PR #4 this session (items 1, 2, 3, 5, 7 — done):
    • app/services/categorizer.py — own API call + own system prompt added (PR #19)
    • app/services/extractor.py — get_client() made public for categorizer.py to reuse (PR #19)
    • app/templates/import/import.html — loading indicator JS added (PR #20)
    • app/templates/import/review.html — loading indicator JS added (PR #21); duplicate warning banner added (PR #23)
    • app/routes/import_.py — duplicate-check logic (_find_duplicate) added before review page render (PR #23)
    • app/templates/recipes/browse.html — delete button + confirm dialog added (PR #22)

Files still NOT yet touched — remaining for item 6 only (starting point for next session):
    • app/services/extractor.py — needs prep_ahead added to JSON schema + system prompt rules
    • app/models/recipe.py — needs prep_ahead, prep_ahead_override columns + migration
    • app/routes/import_.py — needs prep_ahead passed through on save
    • app/routes/recipes.py — needs prep_ahead_override handled on edit
    • app/templates/import/review.html — needs prep_ahead toggle/checkbox
    • app/templates/recipes/form.html — needs prep_ahead_override toggle on edit form
Note: app/routes/recipes.py already has a working DELETE route (no changes were needed for item 3 — the route and cascade relationships pre-existed; only the UI button was missing).

    1. Passwords / Credentials
Server .env files are source of truth. All credentials also stored in Vaultwarden at https://vault.mitchellnet.local/
Saved in: ~/web_server/.env, ~/services/fitness-tracker/.env, ~/services/recipes/.env

API Keys
    • fitness-tracker API key: ae438be7aee8a379e9ed8840797f9328df729ea3b372966424998159bd3b5ff9
    • BIS API key: 2ecc24bbf4eb7a0f82585fdac5008e99274828fa6b79636fc74e815d19441540
    • recipes API key: 1f2b46825b08159d95f8bb9536e24510b4fd80b0ca10284438a426f1a0072318
    • Anthropic API key (mitchellnet-recipes): saved in Vaultwarden — retrieve from https://vault.mitchellnet.local/
    • fitness-tracker key → ~/services/fitness-tracker/.env
    • BIS key → ~/services/bench-instrument-service/.env
    • recipes key + ANTHROPIC_API_KEY → ~/services/recipes/.env

    2. Secrets Storage
Short term: .env files on the LAN-only server are the source of truth. Long term: Vaultwarden (live at https://vault.mitchellnet.local/). .env symlinks added: ~/network-monitoring/.env and ~/monitoring/.env both symlink to ~/web_server/.env. Vaultwarden is fully populated with all credentials including the Anthropic API key. ✅

2.5 Vaultwarden Admin Panel
    • Email: va3wam@gmail.com
    • Master Password: MyVaultwardenPassword$1
    • Hint: Normally caps and dollars are my preferred algorithm
    • Admin token: /VTowpeEmJ76nP8tA/n0au7lfx34RBvLMbf0TAp5FWvFgVqVu5tJ5rCSCrcEr5Qo

2.6 Anthropic Console
    • URL: https://platform.claude.com
    • Login: Google / va3wam@gmail.com
    • Account type: Individual
    • Credits: $5 USD purchased 17 June 2026 (pay-as-you-go — separate from Claude.ai subscription)
    • API key name: mitchellnet-recipes (full key in Vaultwarden)

    3. Full Plan — Current Status
Phase 0 — Security Remediation ✅ COMPLETE
Phase 0.5 — Bare-IP / Name Parity Standard ✅ COMPLETE (20 June 2026) — all path-based services now reachable identically via mitchellnet.local and 192.168.2.10; enforced going forward by aaNewService

Feature/Build Work
    • Item 15 (Recipes app) — PR #4 next (see scope above)
    • Item 20 (RRSP/RRIF app) — analysis complete, build not started

Phase 3 — Monitoring
Phase 4 — IoT

    4. aaNewService — Known Issues
Items A–F fixed in mitchellnet-infra PR #30 (17 June 2026). ✅
Checklist updated 20 June 2026 (mitchellnet-infra PR #37) to explicitly name both NGINX vhost files (prod.conf and 000-bareip.conf) when prompting for the location-block step, instead of a generic one-line reminder. ✅

    5. Recipes App — Remaining PRs
    • PR #4 — IN PROGRESS: items 1, 2, 3, 5, 7 shipped (recipes PR #19–#23, 20 June evening session); item 6 (prep-ahead flag + migration) remaining; item 4 (rating system) deferred
    • PR #5 (planned) — Cook Log (UC-08 + UC-15): "We made this!" button on detail + browse pages; create/edit/delete cook log entries; summary (times made · avg rating · last made) + full log on detail page; per-row count + avg on browse page; new cook_log.py route file + cook_log/edit.html template; no DB migration needed (cook_logs table already exists)
    • PR #6 (planned) — meal plan + shopping list refinements
    • PR #7 (planned) — seed script + data migration from old static recipes.html
    • Recipe-level rating system — deferred pending CookLog usage review
    • Test record cleanup (test, test, test3, test4) in production DB — low priority
    • fetcher.py AllRecipes 403 — low priority, logged 20 June, see § 6.5 Known Issues
    • Expand Cuisine picklist (NEW — 20 June 2026, surfaced while migrating recipes): CUISINES constant in app/routes/recipes.py currently lists American, Asian, Italian, Mediterranean, Mexican, Other — needs at least Thai, Vietnamese, Chinese added, since several migrated recipes are clearly one of those rather than generic "Asian." Small, low-risk change (one list in routes/recipes.py — values are not currently constrained at the DB level, so no migration needed). Open question to resolve when picked up: add these alongside Asian, or have them replace/narrow it for newly-categorized recipes — Andrew to decide, not yet specified.

    6. RRSP/RRIF Withdrawal Planning App — Item 20
Planning and analysis complete. Three documents produced. Build not yet started. HLA review against existing MitchellNET stack still pending before any code is written.

    6.5 Known Issues — Logged, Not Yet Actioned (NEW — 20 June 2026)
A running list of confirmed-but-deferred issues, so they don't get re-discovered from scratch in a future session. None of these are blocking current work.
    • "Not Secure" browser badge on https://192.168.2.10/api/bench/docs despite a valid, trusted cert — root cause not identified after thorough investigation (20 June). See mitchellnet-infra/docs/runbook.md § Incident Log. Low priority, functionality unaffected.
    • AllRecipes.com import returns 403 Forbidden from services/fetcher.py — confirmed via container logs to be a block on AllRecipes' side (likely scraper/bot detection), not a defect in PR #4's changes. Other sources (RecipeTin Eats, etc.) unaffected. Root cause not narrowed to a specific header; a fix (e.g. realistic User-Agent) would be its own small PR. Logged 20 June, not yet actioned.
    • GitHub Actions deprecation annotation: "Node.js 20 is deprecated... actions/setup-python@v5" forced onto Node.js 24 — not a failure, every run still succeeds. Flagged for a future mitchellnet-infra maintenance pass to bump the pinned action version across repos. Logged 20 June, not urgent.
    • Test recipe records (test, test, test3, test4) still in production DB — cleanup not yet done, low priority.
    • Recipe file import fails with 413 Request Entity Too Large on files over ~1MB — confirmed (20 June, testing porkStroganoff.pdf, a 13MB phone-photo PDF) to be NGINX's default client_max_body_size (1MB) rejecting the upload before it reaches Flask, on both the bare-IP and mitchellnet.local vhosts. Workaround used tonight: rasterized the PDF to a compressed JPEG (pdftoppm -jpeg -r 150 -jpegopt quality=82, ~290KB output, still legible) and imported that instead — works but isn't a real fix. Proper fix (not yet done): add client_max_body_size to the /recipes/ location block in BOTH InternalWebServer/nginx/conf.d/prod.conf and nginx/conf.d/000-bareip.conf per the Bare-IP Parity Standard, plus check whether Flask's own MAX_CONTENT_LENGTH (app/app.py, not yet reviewed) also needs raising — fixing only NGINX could just move the failure point to Flask. Will recur for every future cookbook-photo import until fixed.
    • No UPS installed on the server — open follow-up from the 18→19 June unexplained power-loss reboot; all containers recovered correctly on their own, but the gap remains unaddressed.

    7. Lessons Learned — NGINX + Flask Routing
At the start of any new session involving Flask services or NGINX routing, request these two documents before writing any code:
    • recipes/README.md — Development Notes section (Approach A, multi-prefix exception, url_for warning, HTML templates)
    • InternalWebServer/docs/nginx-routing.md — Flask Service Routing Patterns section (same patterns, plus full location block map for all existing services, plus the Bare-IP Parity Standard added 20 June 2026)

Summary of key rules
    • Approach A: trailing slash on proxy_pass strips the prefix — Flask routes use simple paths
    • Multi-prefix exception: secondary prefixes (e.g. /recipes/api/, /meal-plan/, /shopping-list/) use proxy_pass without trailing slash to preserve the full path
    • url_for() is prefix-unaware: always use hard-coded absolute paths for redirects (e.g. redirect(f"/recipes/{r.id}"))
    • HTML anchor tags only: Jinja2 templates must use <a> tags — Markdown-style links render as literal text
    • Bare-IP parity: every service location block must be added to BOTH nginx/conf.d/prod.conf AND nginx/conf.d/000-bareip.conf — exception: subdomain-based services (currently only Vaultwarden) have no bare-IP equivalent and are exempt. Enforced by aaNewService's checklist as of 20 June 2026.

7.5 Lessons Learned — Claude API Integration (18 June 2026)
    • max_tokens must be generous: 1000 caused truncated/unparseable JSON on recipes with many ingredients. Use 4096 as a baseline for structured extraction tasks; consider higher for very complex documents.
    • Don't share a Claude API call function across services with different system prompts: categorizer.py called extractor.call_claude(), silently using the wrong (recipe-extraction) system prompt. Each distinct AI task needs its own client call with its own system prompt — don't reuse "generic" call wrappers across unrelated prompts.
    • curl smoke tests on the server need -k: mitchellnet.local uses a self-signed cert. Plain curl fails silently (empty body via grep); always use curl -sk when testing HTTPS endpoints from the server itself.
    • VSCode Claude plugin can silently mangle large file overwrites: when asking the plugin to replace an entire doc's contents, verify with wc -l and head/tail afterward — don't trust git diff alone if the diff itself looks suspiciously small relative to the intended change. If mangled, it's faster to generate the file via Claude's artifact/file system and have the user copy it in manually than to retry the plugin or fight a heredoc in the terminal (backtick code fences inside heredocs can hang the shell — use a Python triple-quoted string or a downloadable file instead).

7.6 Lessons Learned — Documentation & Process (20 June 2026)
    • A documented warning doesn't prevent a mistake if only the docs say it — the "location blocks must exist in both NGINX files" warning was already written in runbook.md before the BIS bare-IP gap happened, and it still happened. The durable fix was updating aaNewService's checklist itself (tooling), not re-stating the warning more emphatically.
    • When a doc claims to be a complete reference (e.g. "every URL path prefix handled"), verify that claim against the live files (cat / diff) rather than trusting it — a routine audit this session found a documented location block that no longer existed in prod.conf at all, plus several real blocks that were never documented.
    • Pasted terminal output into chat can introduce its own copy/paste artifacts (words merged at line-wrap boundaries), separate from anything the file or the VSCode plugin did. When a diff shown in chat looks suspicious around word boundaries, verify the actual file content directly (e.g. python3 -c "print('substring' in open(path).read())") rather than trusting the pasted diff text — this caught several false issues today. sed/grep pattern matching on em-dash and other multi-byte characters proved unreliable on macOS; Python string operations were the reliable fallback.

7.7 Lessons Learned — One-Item-Per-PR Workflow & Live Verification (NEW — 20 June evening session)
    • Splitting a multi-item scoped PR (PR #4) into one PR per item, each promoted/merged/deploy-verified independently, kept every diff small enough to fully read and reason about before promoting — no large multi-file diffs to skim. Worth continuing as the default pattern for future multi-item scopes.
    • The GitHub merge screen's "X checks pending" indicator can lag behind the actual Actions run completing — confirmed by checking the Actions tab directly after a merge that showed "1 check was pending," which turned out to already be a passed "Deploy to Production" run. The Actions tab, not the merge screen, is the authoritative source for deploy status per the standing Deploy Verification step.
    • Code-review-confidence and live-behavior-confidence are different things, especially for logic with a numeric threshold (e.g. difflib's 0.8 fuzzy-match cutoff) — the duplicate-detection PR was correct on diff review, but worth an actual live import against a known-duplicate name to confirm the threshold behaves as intended in practice, not just in theory. The first live test (AllRecipes) failed for an unrelated reason (403 block) before reaching the duplicate-check code at all — a reminder that "the feature didn't show up" can mean an earlier step in the pipeline failed, not that the feature itself is broken; always check the actual error (container logs) before assuming the new code is at fault.
    • When deliberately testing duplicate-detection by re-importing an existing recipe, discard the resulting review page rather than saving — otherwise the test itself creates the duplicate record the feature was built to warn about.

    8. InternalWebServer — Site Structure
Navigation
Home | Engineering | Workspaces | Infrastructure | Projects | About

Reference Hubs
    • /engineering/ — Electronics, PCB design, embedded systems, AI/ML, software development
    • /workshop/ — Workspaces: Machine shop, wood shop, music studio, 3D printing, electrical, design software
    • /infrastructure/ — Network design, server setup, monitoring, home automation

Hosted Apps
    • /fitness/ — Fitness Tracker
    • /recipes/ — Recipes app (Flask + MariaDB)
    • /rrsp/ — RRSP/RRIF Withdrawal Planning app (planned — Item 20)

Infrastructure → Hosted Services
    • Vaultwarden — https://vault.mitchellnet.local/

    8.5 InternalWebServer — Backlog / Maintenance (NEW — 20 June 2026)
Two items added to the backlog this session, neither started:
    1. Re-clone InternalWebServer to the standard repo location. Currently at ~/Documents/visualStudioCode/html/projects/InternalWebServer — the one exception to the newProjectStructure pattern all other repos use (~/Documents/visualStudioCode/newProjectStructure/<repo>). Goal: re-clone to ~/Documents/visualStudioCode/newProjectStructure/InternalWebServer for consistency. Claude's assessment (not yet verified hands-on): git itself, GitHub, branch protection, CI/CD, and the server-side deploy pipeline are all independent of the local Mac clone path, so a straight re-clone should be safe. The one real unknown: it hasn't been confirmed whether any of the aaGit* / aaNewService helper scripts hardcode the old html/projects/InternalWebServer path anywhere — plausible, since Standing Instructions already special-case this repo as the sole exception. Recommended approach when this is picked up: do a fresh clone to the new path first, verify it works (aaGitPromote/aaGitCleanupBranches run cleanly from the new location, VSCode opens it correctly), and only delete the old clone after that's confirmed — don't delete-then-discover. Once done, the "Repo Locations on Mac Studio" entry in Standing Instructions (and the REPOS section of the Resume Prompt below) will need updating to drop the exception.
    2. InternalWebServer site IA / structure cleanup. Some pages are no longer linked/used (the orphaned recipes.html discovered this session is a known example — there may be others), and the overall site structure has grown inconsistently over time. Needs an audit pass first (which pages are actually linked from the live nav vs. orphaned, similar to how recipes.html was found) before any redesign work starts. Not scoped in detail yet — scope and approach to be defined at the start of whichever session picks this up.

    9. Resume Prompt (paste this verbatim to start the next session)

Resuming MitchellNET work.

We use this workflow: you tell me step-by-step what to either (1) run on the server SSH terminal, (2) run on the Dev Mac terminal, or (3) tell the Claude plugin in VSCode to do — one repo at a time, since I have to switch VSCode windows per repo. Always tell me which repo I should be in before giving instructions. I paste back outputs/diffs for your review before we proceed. For commits we use aaGitPromote <branch> "<msg>" and aaGitCleanupBranches (never delete branches via GitHub UI — I don't click "Delete branch" on GitHub either, the script handles it). PRs are merged via GitHub UI after CI passes. For literal file dumps, give me raw cat/grep commands rather than asking the plugin to "show" files. Always pipe git diff through cat to prevent pager hang: git diff | cat. After any edit, get the diff before promoting.

We stay on the main branch at all times in the Dev Mac terminal — aaGitPromote creates the feature branch itself, commits, and pushes; I never manually git checkout -b.

At the start of any session involving Flask services or NGINX routing, request these two docs before writing any code:
    • recipes/README.md — Development Notes section
    • InternalWebServer/docs/nginx-routing.md — Flask Service Routing Patterns section (includes the Bare-IP Parity Standard added 20 June 2026 — every location block must exist in both nginx/conf.d/prod.conf and nginx/conf.d/000-bareip.conf, except subdomain-based services like Vaultwarden which are exempt)

If the VSCode plugin's diff for a large file replacement looks too small or suspicious, verify with wc -l and head/tail before trusting it — the plugin can silently truncate large file overwrites. If a file gets mangled, don't fight it with heredocs (backtick fences can hang the terminal) — generate the file as a downloadable artifact instead and have me copy it into the repo manually. Separately: if I paste terminal output back to you and a diff or check looks suspicious around word boundaries (especially near em dashes or other punctuation), don't assume the file is broken — verify with a direct Python read of the file before troubleshooting further, since the paste step itself has been an unreliable source of artifacts in past sessions.

After every PR merge, check the Actions tab for "Deploy to Production" directly — don't rely on the GitHub merge screen's check-status badge, which can show "checks pending" even after the run has actually succeeded.

Current state as of end of 22 June 2026 planning session:

CONFIRMED THIS SESSION (no code written, planning only):
    • Cook Log / UC-15 fully designed and locked — see § 5 for PR #5 scope
    • BRD updated to v1.2 (UC-08 rewritten, UC-15 added, UC-02 updated, success criteria updated)
    • HLA updated to v1.2 (cook_log.py route file + cook_log/edit.html + § 6.6 Cook Log Routes + PR table updated)
    • Migration approach confirmed: Flask-Migrate (Alembic) — migrations/ directory exists in the repo; no migration needed for cook_logs (table already exists); prep_ahead + prep_ahead_override migration still needed for PR #4 item 6
    • Roadmap now lives permanently in mitchellnet-infra/docs/ (moved this session)
    • main is at commit 9cbeafc (no code changes this session)

NOT STARTED — RECIPES PR #4, ITEM 6 (this is the focus for the next session):
    • Prep-ahead flag — design locked: Claude attempts to detect prep-ahead steps (overnight marinating, dough resting, etc.) during extraction and sets prep_ahead in the JSON schema; user can manually override via a prep_ahead_override column on both the review form and the edit form.
    • Needs a DB migration for the recipes table (prep_ahead, prep_ahead_override columns). The migration approach/tooling for this repo has not yet been confirmed — no migrations/ directory was found as of the 18 June scaffold, so it's likely raw SQL against database/init.sql plus a manual ALTER TABLE, but this should be confirmed at the start of the session rather than assumed.
    • Files expected to need changes: app/services/extractor.py (JSON schema + system prompt), app/models/recipe.py (+ migration), app/routes/import_.py (pass prep_ahead through on save), app/routes/recipes.py (handle prep_ahead_override on edit), app/templates/import/review.html (prep_ahead toggle), app/templates/recipes/form.html (prep_ahead_override toggle on edit)

DEFERRED, NO CHANGE THIS SESSION:
    • Item 4 — wishlist → rating system: still deferred, need to see CookLog rating in actual use before deciding aggregation approach. Wishlist stays as-is.

KNOWN ISSUES — logged this session, not yet actioned, not blocking:
    • AllRecipes.com import returns 403 Forbidden from services/fetcher.py — confirmed via container logs to be a block on AllRecipes' side (scraper/bot detection), not a defect from this session's changes. Other sources (RecipeTin Eats, etc.) work fine. A fix (e.g. realistic User-Agent header) would be its own small PR if pursued — out of scope for PR #4.
    • GitHub Actions deprecation annotation: "Node.js 20 is deprecated... actions/setup-python@v5" forced onto Node.js 24. Not a failure — every run this session still succeeded. Flagged for a future mitchellnet-infra maintenance pass to bump the pinned action version across repos.
    • Recipe file import (PDF/image upload) fails with 413 Request Entity Too Large above ~1MB — NGINX's default client_max_body_size, hit on both vhosts. Workaround for now: rasterize large PDFs/photos to a compressed JPEG before uploading (pdftoppm -jpeg -r 150 -jpegopt quality=82 works well). Real fix needs client_max_body_size added to the /recipes/ location block in both InternalWebServer/nginx/conf.d/prod.conf and 000-bareip.conf, plus a check of app/app.py for Flask's own MAX_CONTENT_LENGTH — not yet reviewed. Will keep recurring on cookbook-photo imports until fixed.

RECIPE MIGRATION IN PROGRESS (started this session, ongoing across sessions, not a PR #4 item):
    • Recovered the original recipe list from InternalWebServer's orphaned static page (html/prod/recipes/recipes.html — never deleted, just unlinked from nav when the Flask app went live). 48 external URLs identified, deduplicated, grouped by source; 1 local PDF (porkStroganoff.pdf — imported successfully as a pre-compressed JPEG to work around the 413 issue above); 6 cookbook page references (Nagi cookbook + New Nagi cookbook) still to be added manually via "Add Recipe" since they have no URL.
    • FIRST IMPORT PASS COMPLETE (20 June): 44 of 48 URLs imported successfully. "Garlic Prawns (Shrimp)" was correctly skipped/not duplicated despite being on the list (already in the DB from earlier testing) — duplicate detection (PR #23) was not even needed here since it was simply not re-attempted.
    • 4 URLs FAILED AND ARE BEING DISCARDED — no further action required, not being retried:
        ◦ https://www.allrecipes.com/recipe/257938/spicy-thai-basil-chicken-pad-krapow-gai/ — 403 Forbidden (the known AllRecipes bot-block, see § 6.5 Known Issues — that entry stays open since it could affect future AllRecipes links too, but this specific recipe is abandoned)
        ◦ https://aginglikewine.com/dinner-is-served/braised-lamb-shanks/ — 404 Not Found, the page no longer exists at that URL
        ◦ https://www.yummly.com/recipe/Killer-Chicken-Thigh-Marinade-9035934 — redirected to kitchenaid.com, which then timed out; Yummly may no longer be operating as a standalone recipe site (unconfirmed, a verifying web search timed out)
        ◦ https://www.foodnetwork.ca/recipe/souvlaki-style-pork-tenderloin-with-a-tomato-olive-feta-and-roasted-red-pepper-salad/15234/ — SSL handshake error (TLSV1_ALERT_INTERNAL_ERROR) talking to FoodNetwork.ca's server
    • OPEN FOLLOW-UP (Andrew's own, not delegated to Claude): https://insanelygoodrecipes.com/vietnamese-recipes/ imported as a YES, but the URL pattern looks like a category/listing page rather than a single recipe — Andrew flagged this himself and will check the saved recipe's detail page to confirm Claude extracted one real recipe rather than garbled listing-page content.
    • REMAINING: 6 cookbook page references (Nagi cookbook + New Nagi cookbook) still need manual "Add Recipe" entry — no URL to import from.

Also pending (lower priority, not blocking):
    • Clean up test recipe records (test, test, test3, test4) from production DB
    • RRSP app (Item 20): HLA review against existing MitchellNET stack still needed before build starts
    • No UPS installed on the server — open follow-up from the 18→19 June power-loss reboot
    • InternalWebServer backlog (NEW — 20 June 2026), neither started: (1) re-clone the repo to the standard ~/Documents/visualStudioCode/newProjectStructure/ location instead of its current one-off path — see § 8.5 for Claude's assessment of what could/couldn't break; (2) site IA/structure cleanup — unused pages need an audit, structure needs a redesign pass for consistency — see § 8.5
    • Expand Cuisine picklist (NEW — 20 June 2026): add at least Thai, Vietnamese, Chinese to the CUISINES constant in app/routes/recipes.py — surfaced while migrating recipes that were clearly more specific than generic "Asian." Small change, see § 5 for detail and the open question (add alongside Asian, or narrow it).

REPOS (all at ~/Documents/visualStudioCode/newProjectStructure/<repo> except InternalWebServer which is at ~/Documents/visualStudioCode/html/projects/InternalWebServer):
    • fitness-tracker — https://mitchellnet.local/fitness/
    • bench-instrument-service (BIS) — https://mitchellnet.local/api/bench/ and https://192.168.2.10/api/bench/ (both confirmed working as of 20 June 2026)
    • mitchellnet-infra — scripts, runbook, architecture docs
    • InternalWebServer — NGINX config, static HTML
    • vaultwarden — https://vault.mitchellnet.local/
    • recipes — https://mitchellnet.local/recipes/ (full UI + Claude import live, PR #4 Part 1 shipped, item 6 next)
    • mitchellnet-rrsp — NOT YET CREATED (Item 20, planned)

SERVER: Ubuntu iMac at 192.168.2.10, SSH as andrew@192.168.2.10. Services run from ~/services/<repo>/. All credentials in Vaultwarden at https://vault.mitchellnet.local/ and in server .env files. No UPS currently installed — an unexplained power-loss reboot occurred 18→19 June 2026; all containers recovered correctly on their own.

Please start by confirming you have context. The immediate focus is recipes PR #4 item 6 (prep-ahead flag). Migration approach is confirmed — Flask-Migrate/Alembic (migrations/ directory exists in the repo). Since this involves Flask service work, also request the recipes/README.md Development Notes section if any routing-adjacent code is touched. After PR #4 item 6 is merged, the next scope is Cook Log (PR #5) — design is fully locked and documented in BRD v1.2 UC-15 and HLA v1.2 § 6.6.


MitchellNET — Standing Instructions
Workflow
    • You (Claude) plan/review; I execute via two channels: (1) server terminal commands, (2) instructions to the Claude plugin in VSCode for file edits within a repo.
    • Repos are separate VSCode windows — always tell me explicitly which repo I should be working in before giving instructions, and don't mix instructions for two repos in one step.
    • For literal file dumps, give me raw cat/grep/git diff commands to run myself rather than asking the VSCode plugin to "show" or "summarize" a file.
    • Always pipe git diff through cat to prevent pager hang: git diff | cat
    • After any edit, get the git diff | cat before promoting, to catch stray changes.
    • Stay on main in the terminal at all times — aaGitPromote creates the branch itself.
    • If I paste terminal output back and something looks like a word got merged or split unexpectedly (especially around em dashes or punctuation), treat it as a possible paste artifact first — verify against the real file directly before assuming the file itself is broken.

Git Workflow
    • Commit via aaGitPromote <branch-name> "<commit message>" (creates branch, commits, pushes, prints PR link). Run from main.
    • I open/merge PRs via GitHub UI after CI passes. I do not click "Delete branch" in GitHub.
    • After merge, clean up via aaGitCleanupBranches (switches to main, deletes local+remote branch, pulls latest).

Deploy Verification
    • After merge, check the Actions tab for "Deploy to Production" — if it fails, check container logs via docker compose logs <service> --tail=50 before assuming the code change is broken (deploy health-check timing issues are a known false-positive).

Repos
    • fitness-tracker (Flask) — https://192.168.2.10/fitness/ and https://mitchellnet.local/fitness/
    • bench-instrument-service / BIS (FastAPI) — https://mitchellnet.local/api/bench/ and https://192.168.2.10/api/bench/
    • mitchellnet-infra — scripts (aaGitPromote, aaGitCleanupBranches, etc.), runbook, architecture docs
    • InternalWebServer — NGINX config, static HTML, docker-compose for nginx-proxy + nginx-prod
    • vaultwarden — https://vault.mitchellnet.local/ (subdomain vhost, exempt from bare-IP parity by design)
    • recipes — https://mitchellnet.local/recipes/ (Flask + MariaDB, full UI + Claude import live)
    • mitchellnet-rrsp — NOT YET CREATED (Item 20, planned)

Bare-IP / Name Parity Standard (NEW — 20 June 2026)
    • Every path-based service location block must exist in both nginx/conf.d/prod.conf and nginx/conf.d/000-bareip.conf — enforced by aaNewService's checklist.
    • Subdomain-based services (currently only Vaultwarden) are exempt — there is no bare-IP equivalent of a subdomain.
    • Full detail: InternalWebServer/docs/nginx-routing.md § Bare-IP Parity Standard, and mitchellnet-infra/docs/runbook.md § SSL Certificate Renewal and § Incident Log.

Secrets
Server .env files are source of truth. Vaultwarden is live and fully populated — use it as the credential reference.

Repo Locations on Mac Studio
    • newProjectStructure repos: ~/Documents/visualStudioCode/newProjectStructure/<repo>
    • InternalWebServer: ~/Documents/visualStudioCode/html/projects/InternalWebServer
