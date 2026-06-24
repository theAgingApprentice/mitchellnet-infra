#!/bin/bash
# Rebuilds the Ubuntu server from scratch.

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

print_step() {
    echo ""
    echo "============================================================"
    echo "  $1"
    echo "============================================================"
}

print_step "Checking Docker installation..."
if ! command -v docker &>/dev/null; then
    echo "ERROR: Docker is not installed."
    echo ""
    echo "Install Docker with:"
    echo "  curl -fsSL https://get.docker.com | sh"
    echo "  sudo usermod -aG docker andrew"
    echo ""
    echo "Then log out and back in, and re-run this script."
    exit 1
fi
echo "Docker is installed: $(docker --version)"

print_step "Creating mitchellnet Docker network..."
bash "${REPO_ROOT}/network/create.sh"

print_step "Generating mkcert SSL certificate for mitchellnet.local..."
bash "${REPO_ROOT}/ssl/generate.sh"

print_step "Adding mitchellnet.local to /etc/hosts..."
if grep -q "mitchellnet.local" /etc/hosts; then
    echo "mitchellnet.local already in /etc/hosts — skipping."
else
    echo "127.0.0.1 mitchellnet.local" | sudo tee -a /etc/hosts
    echo "Added mitchellnet.local to /etc/hosts."
fi

print_step "Installing scripts to /usr/local/bin..."
bash "${REPO_ROOT}/scripts/aaInstall"

print_step "Installing recipes DB backup script and cron job..."
BACKUP_DIR="/home/andrew/backups/recipes"
SCRIPT_SRC="${REPO_ROOT}/server-scripts/backup_recipes_db.sh"
SCRIPT_DEST="${BACKUP_DIR}/backup_recipes_db.sh"
mkdir -p "$BACKUP_DIR"
cp "$SCRIPT_SRC" "$SCRIPT_DEST"
chmod +x "$SCRIPT_DEST"
# Install cron job if not already present
CRON_JOB="0 2 * * * $SCRIPT_DEST"
if crontab -l 2>/dev/null | grep -qF "$SCRIPT_DEST"; then
    echo "Cron job already installed — skipping."
else
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
    echo "Cron job installed: $CRON_JOB"
fi

print_step "Bootstrap complete!"
echo ""
echo "Next steps (manual):"
echo ""
echo "  1. Register GitHub Actions runners for each service repo:"
echo "       aaRegisterRunner InternalWebServer"
echo "       aaRegisterRunner fitness-tracker"
echo "       aaRegisterRunner bench-instrument-service"
echo "       aaRegisterRunner vaultwarden"
echo "       aaRegisterRunner mitchellnet-monitoring"
echo "       aaRegisterRunner mitchellnet-device-registry"
echo ""
echo "  2. Deploy each service from its own GitHub repo:"
echo "       cd /home/andrew/services/<repo-name>"
echo "       docker compose up -d"
echo ""
echo "  3. Verify the recipes DB backup cron job:"
echo "       crontab -l"
echo "       ~/backups/recipes/backup_recipes_db.sh"
echo "       cat ~/backups/recipes/backup.log"
echo ""
echo "  See docs/runbook.md for full step-by-step details."
