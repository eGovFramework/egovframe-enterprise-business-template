#!/usr/bin/env bash
set -euo pipefail
# 캐시/권한/훅 등 공통 준비
git config --global --add safe.directory /workspace || true
echo "✅ Dev setup done."