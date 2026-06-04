#!/usr/bin/env bash
# =============================================================================
# ssl/generate.sh
# Generates a locally-trusted wildcard TLS certificate for mitchellnet.local
# using mkcert. Certificates are placed in ssl/certs/ and mounted into the
# NGINX container by InternalWebServer.
#
# Prerequisites:
#   - mkcert installed: https://github.com/FiloSottile/mkcert
#   - On Ubuntu: sudo apt install libnss3-tools && <install mkcert binary>
#   - On macOS:  brew install mkcert
#
# Run once on a fresh host, or after certificate expiry (10-year lifetime).
# The ssl/certs/ directory is git-ignored — never commit certificates or keys.
#
# Usage:
#   bash ssl/generate.sh
# =============================================================================

set -euo pipefail

CERT_DIR="$(dirname "$0")/certs"
DOMAIN="mitchellnet.local"

# ---------------------------------------------------------------------------
# Check mkcert is available
# ---------------------------------------------------------------------------
if ! command -v mkcert > /dev/null 2>&1; then
  echo "✗ mkcert not found. Install it first:"
  echo ""
  echo "  macOS:  brew install mkcert"
  echo "  Ubuntu: see https://github.com/FiloSottile/mkcert#linux"
  echo ""
  exit 1
fi

# ---------------------------------------------------------------------------
# Install the local CA (safe to re-run)
# ---------------------------------------------------------------------------
echo "→ Installing mkcert local CA (may prompt for sudo)..."
mkcert -install
echo "✓ Local CA installed."

# ---------------------------------------------------------------------------
# Create output directory
# ---------------------------------------------------------------------------
mkdir -p "${CERT_DIR}"

# ---------------------------------------------------------------------------
# Generate wildcard certificate
# ---------------------------------------------------------------------------
echo ""
echo "→ Generating certificate for: ${DOMAIN}, *.${DOMAIN}, localhost, 127.0.0.1"
cd "${CERT_DIR}"
mkcert "${DOMAIN}" "*.${DOMAIN}" localhost 127.0.0.1

echo ""
echo "✓ Certificate files written to ssl/certs/:"
ls -1 "${CERT_DIR}"

echo ""
echo "Next steps:"
echo "  1. Update InternalWebServer nginx config to reference these cert paths."
echo "  2. On any Mac used for local dev, run: mkcert -install"
echo "  3. Commit nothing in ssl/certs/ — it is git-ignored."
