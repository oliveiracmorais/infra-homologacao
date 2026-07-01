#!/bin/bash
set -e

echo "Creating databases and users..."

# ---------- Fiscal ----------
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE fiscal_homol;
    CREATE USER fiscal_user WITH PASSWORD '${FISCAL_DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON DATABASE fiscal_homol TO fiscal_user;
    \c fiscal_homol
    GRANT ALL ON SCHEMA public TO fiscal_user;
EOSQL

# ---------- Fapitec ----------
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE fapitec_homol;
    CREATE USER fapitec_user WITH PASSWORD '${FAPITEC_DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON DATABASE fapitec_homol TO fapitec_user;
    \c fapitec_homol
    GRANT ALL ON SCHEMA public TO fapitec_user;
EOSQL

# ---------- Revmotrix ----------
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE revmotrix_homol;
    CREATE USER revmotrix_user WITH PASSWORD '${REVMOTRIX_DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON DATABASE revmotrix_homol TO revmotrix_user;
    \c revmotrix_homol
    GRANT ALL ON SCHEMA public TO revmotrix_user;
EOSQL

echo "Databases and users created successfully."
