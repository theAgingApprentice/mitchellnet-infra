#!/usr/bin/env bash
# =============================================================================
# network/create.sh
# Creates the mitchellnet external Docker network.
#
# Run this once on a fresh host before deploying any MitchellNET service.
# Safe to re-run — exits cleanly if the network already exists.
#
# Usage:
#   bash network/create.sh
# =============================================================================

set -euo pipefail

NETWORK_NAME="mitchellnet"

echo "→ Checking for Docker network: ${NETWORK_NAME}"

if docker network inspect "${NETWORK_NAME}" > /dev/null 2>&1; then
  echo "✓ Network '${NETWORK_NAME}' already exists — nothing to do."
else
  echo "→ Creating network '${NETWORK_NAME}'..."
  docker network create "${NETWORK_NAME}"
  echo "✓ Network '${NETWORK_NAME}' created."
fi

echo ""
echo "Network details:"
docker network inspect "${NETWORK_NAME}" \
  --format "  ID:     {{.ID}}" 2>/dev/null || true
docker network inspect "${NETWORK_NAME}" \
  --format "  Driver: {{.Driver}}" 2>/dev/null || true
docker network inspect "${NETWORK_NAME}" \
  --format "  Scope:  {{.Scope}}" 2>/dev/null || true
