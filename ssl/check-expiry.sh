#!/usr/bin/env bash
# =============================================================================
# ssl/check-expiry.sh
# Checks the expiry date of the mitchellnet.local TLS certificate and warns
# if it expires within 90 days.
#
# mkcert certificates are valid for ~10 years, so this is low-urgency —
# but worth running occasionally, or adding to a monthly cron job:
#
#   # crontab -e
#   0 9 1 * * bash /home/andrew/services/mitchellnet-infra/ssl/check-expiry.sh
#
# Usage:
#   bash ssl/check-expiry.sh
# =============================================================================

set -euo pipefail

CERT_DIR="$(dirname "$0")/certs"
WARN_DAYS=90

# ---------------------------------------------------------------------------
# Find the certificate file
# ---------------------------------------------------------------------------
CERT_FILE=$(find "${CERT_DIR}" -name "*.pem" ! -name "*-key.pem" 2>/dev/null | head -1)

if [[ -z "${CERT_FILE}" ]]; then
  echo "✗ No certificate found in ${CERT_DIR}/"
  echo "  Run ssl/generate.sh to create one."
  exit 1
fi

# ---------------------------------------------------------------------------
# Check openssl is available
# ---------------------------------------------------------------------------
if ! command -v openssl > /dev/null 2>&1; then
  echo "✗ openssl not found — cannot check certificate expiry."
  exit 1
fi

# ---------------------------------------------------------------------------
# Parse expiry date
# ---------------------------------------------------------------------------
EXPIRY_DATE=$(openssl x509 -enddate -noout -in "${CERT_FILE}" | cut -d= -f2)
EXPIRY_EPOCH=$(date -d "${EXPIRY_DATE}" +%s 2>/dev/null \
  || date -j -f "%b %d %T %Y %Z" "${EXPIRY_DATE}" +%s 2>/dev/null)
NOW_EPOCH=$(date +%s)
DAYS_REMAINING=$(( (EXPIRY_EPOCH - NOW_EPOCH) / 86400 ))

echo "Certificate: ${CERT_FILE}"
echo "Expires:     ${EXPIRY_DATE}"
echo "Days left:   ${DAYS_REMAINING}"
echo ""

if [[ ${DAYS_REMAINING} -le 0 ]]; then
  echo "✗ CERTIFICATE HAS EXPIRED. Run ssl/generate.sh immediately."
  exit 2
elif [[ ${DAYS_REMAINING} -le ${WARN_DAYS} ]]; then
  echo "⚠ WARNING: Certificate expires in ${DAYS_REMAINING} days."
  echo "  Run ssl/generate.sh to renew."
  exit 1
else
  echo "✓ Certificate is valid for ${DAYS_REMAINING} more days. No action needed."
fi
