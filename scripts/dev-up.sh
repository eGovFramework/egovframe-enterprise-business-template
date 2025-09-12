#!/usr/bin/env bash
set -euo pipefail
docker compose up -d
echo "🚀 Ready. Attach to container or run: mvn -B spring-boot:run"