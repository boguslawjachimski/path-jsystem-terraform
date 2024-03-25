#!/bin/bash
docker compose up -d
echo "Contener with PostgreSQL database is up and running"
echo "You can connect to it using: terraform init with -backend-config=postgresql://postgres:postgres@localhost:5432/postgres?sslmode=disable"
echo ""
echo "Just run terraform init"