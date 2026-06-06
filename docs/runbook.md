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
