#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="${1:-$ROOT_DIR/backups}"
POSTGRES_USER="${POSTGRES_USER:-$(docker compose -f "$ROOT_DIR/docker-compose.yml" exec -T db printenv POSTGRES_USER)}"
POSTGRES_DB="${POSTGRES_DB:-$(docker compose -f "$ROOT_DIR/docker-compose.yml" exec -T db printenv POSTGRES_DB)}"
TIMESTAMP="$(date -u +%Y%m%dT%H%M%SZ)"
BACKUP_FILE="$BACKUP_DIR/${POSTGRES_DB}_${TIMESTAMP}.dump"

mkdir -p "$BACKUP_DIR"
docker compose -f "$ROOT_DIR/docker-compose.yml" exec -T db \
  pg_dump --username="$POSTGRES_USER" --dbname="$POSTGRES_DB" --format=custom > "$BACKUP_FILE"

printf 'Backup created: %s\n' "$BACKUP_FILE"
