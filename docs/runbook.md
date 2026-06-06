# MitchellNET Runbook

Step-by-step procedures for rebuilding or extending MitchellNET infrastructure. For system design rationale, see [ARCHITECTURE.md](ARCHITECTURE.md).

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
