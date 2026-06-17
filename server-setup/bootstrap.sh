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
echo "  See docs/runbook.md for full step-by-step details."
