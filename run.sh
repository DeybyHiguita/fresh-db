#!/bin/bash
# =============================================
# Fresh - Ejecutar scripts SQL
# =============================================
# Uso:
#   ./run.sh                    → Ejecuta init.sql (todo)
#   ./run.sh tables/01_users.sql → Ejecuta un script específico
#   ./run.sh seeds/01_categories.sql → Ejecuta un seed específico
# =============================================

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Conexión a Neon PostgreSQL
DB_HOST="${DB_HOST:-ep-bitter-wildflower-amdy6uti-pooler.c-5.us-east-1.aws.neon.tech}"
DB_NAME="${DB_NAME:-dbfresh}"
DB_USER="${DB_USER:-neondb_owner}"
DB_PASSWORD="${DB_PASSWORD:-}"
DB_SSLMODE="${DB_SSLMODE:-require}"

if [ -z "$DB_PASSWORD" ]; then
  echo "Error: Falta la variable DB_PASSWORD"
  echo ""
  echo "Uso:"
  echo "  DB_PASSWORD=tu_password ./run.sh"
  echo "  DB_PASSWORD=tu_password ./run.sh tables/01_users.sql"
  exit 1
fi

CONNECTION="host=$DB_HOST dbname=$DB_NAME user=$DB_USER password=$DB_PASSWORD sslmode=$DB_SSLMODE"

# Script a ejecutar (por defecto: init.sql)
SQL_FILE="${1:-init.sql}"

if [ ! -f "$SCRIPT_DIR/$SQL_FILE" ]; then
  echo "Error: No se encontró el archivo $SQL_FILE"
  exit 1
fi

echo "=== Fresh Database ==="
echo "  Host: $DB_HOST"
echo "  Base: $DB_NAME"
echo "  Script: $SQL_FILE"
echo ""

cd "$SCRIPT_DIR"
psql "$CONNECTION" -f "$SQL_FILE"

echo ""
echo "=== Listo ==="
