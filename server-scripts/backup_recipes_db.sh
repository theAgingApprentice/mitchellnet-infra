#!/bin/bash
# backup_recipes_db.sh — nightly MariaDB dump for recipes_db.
# Runs on the Ubuntu server via cron. Not a Dev Mac script.
#
# Retention: keeps the last 3 dumps to prevent disk fill.
# Credentials: reads from ~/services/recipes/.env — do not hard-code here.
#
# TODO (Phase 3 — Monitoring): on failure, emit an SNMP trap or post a
# Grafana annotation so the backup gap appears on the MitchellNET dashboard.
#
# Install / cron registration:
#   See server-setup/bootstrap.sh and docs/runbook.md § Recipes DB Backup.

set -euo pipefail

BACKUP_DIR="$HOME/backups/recipes"
CONTAINER="recipes-db"
DB_NAME="recipes_db"
KEEP=3
DATESTAMP=$(date +%Y-%m-%d)
OUTFILE="$BACKUP_DIR/recipes_db_${DATESTAMP}.sql"
LOGFILE="$BACKUP_DIR/backup.log"

# Load credentials from .env
ENV_FILE="$HOME/services/recipes/.env"
if [ ! -f "$ENV_FILE" ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR .env not found at $ENV_FILE" >> "$LOGFILE"
    exit 1
fi
DB_ROOT_PASSWORD=$(grep '^MYSQL_ROOT_PASSWORD=' "$ENV_FILE" | cut -d= -f2)

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

mkdir -p "$BACKUP_DIR"

log "INFO  Starting backup → $OUTFILE"

docker exec "$CONTAINER" \
    mysqldump -uroot -p"$DB_ROOT_PASSWORD" "$DB_NAME" > "$OUTFILE"

if [ $? -ne 0 ]; then
    log "ERROR mysqldump failed — check: docker logs $CONTAINER"
    rm -f "$OUTFILE"
    exit 1
fi

if [ ! -s "$OUTFILE" ]; then
    log "ERROR Dump file is zero bytes — removing"
    rm -f "$OUTFILE"
    exit 1
fi

SIZE=$(du -h "$OUTFILE" | cut -f1)
log "OK    Dump complete — $OUTFILE ($SIZE)"

# Prune oldest dumps, retain only $KEEP most recent
EXISTING=$(ls -1t "$BACKUP_DIR"/recipes_db_*.sql 2>/dev/null)
COUNT=$(echo "$EXISTING" | grep -c . || true)
if [ "$COUNT" -gt "$KEEP" ]; then
    echo "$EXISTING" | tail -n +$((KEEP + 1)) | while read -r OLD; do
        rm -f "$OLD"
        log "PRUNE Removed old backup: $(basename "$OLD")"
    done
fi

RETAINED=$(ls -1 "$BACKUP_DIR"/recipes_db_*.sql 2>/dev/null | wc -l)
log "INFO  Done. Backups retained: $RETAINED / max $KEEP"
