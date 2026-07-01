#!/bin/bash
set -euo pipefail

BACKUP_DIR="/srv/homol/volumes/backups"
DATE=$(date +%Y%m%d_%H%M%S)
PG_USER="postgres"
APPS=("fiscal_homol" "fapitec_homol" "revmotrix_homol")

mkdir -p "$BACKUP_DIR"

echo "[$(date)] Starting backup..."

for db in "${APPS[@]}"; do
    echo "  Backing up $db..."
    docker exec homol-pg pg_dump -U "$PG_USER" "$db" | gzip > "$BACKUP_DIR/${db}_${DATE}.sql.gz"
    echo "  Done: ${BACKUP_DIR}/${db}_${DATE}.sql.gz ($(du -h "${BACKUP_DIR}/${db}_${DATE}.sql.gz" | cut -f1))"
done

# Remove backups older than 7 days
find "$BACKUP_DIR" -name "*.sql.gz" -mtime +7 -delete

echo "[$(date)] Backup complete."
