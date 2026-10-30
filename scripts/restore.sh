#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_FILE="${1:-}"
TARGET_DB="${2:-hotel_bookings_restore}"

if [[ -z "$BACKUP_FILE" ]]; then
  BACKUP_FILE="$(find "$ROOT_DIR/backups" -maxdepth 1 -type f -name '*.dump' -print 2>/dev/null | sort | tail -n 1)"
  if [[ -z "$BACKUP_FILE" ]]; then
    printf 'No backup found. Pass a dump path as the first argument.\n' >&2
    exit 1
  fi
fi

if [[ ! -f "$BACKUP_FILE" ]]; then
  printf 'Backup file does not exist: %s\n' "$BACKUP_FILE" >&2
  exit 1
fi

if [[ "$TARGET_DB" == "hotel_bookings" || "$TARGET_DB" == "postgres" || "$TARGET_DB" == "template0" || "$TARGET_DB" == "template1" ]]; then
  printf 'Refusing to replace protected database: %s\n' "$TARGET_DB" >&2
  exit 1
fi

POSTGRES_USER="${POSTGRES_USER:-$(docker compose -f "$ROOT_DIR/docker-compose.yml" exec -T db printenv POSTGRES_USER)}"

docker compose -f "$ROOT_DIR/docker-compose.yml" exec -T db \
  dropdb --if-exists --username="$POSTGRES_USER" "$TARGET_DB"
docker compose -f "$ROOT_DIR/docker-compose.yml" exec -T db \
  createdb --username="$POSTGRES_USER" "$TARGET_DB"
docker compose -f "$ROOT_DIR/docker-compose.yml" exec -T db \
  pg_restore --username="$POSTGRES_USER" --dbname="$TARGET_DB" --no-owner --no-privileges < "$BACKUP_FILE"

printf 'Restored %s into fresh database: %s\n' "$BACKUP_FILE" "$TARGET_DB"
