#!/usr/bin/env bash
# Docker 실행
# 환경 변수는 .env 또는 셸에서 미리 설정. .env.example 참고.
set -euo pipefail

: "${EGOV_EBT_VERSION:=5.0.0}"
: "${MYSQL_VERSION:=8.0.39}"
: "${MYSQL_DATABASE:=ebt}"
: "${MYSQL_USER:=root}"

if [[ -z "${MYSQL_ROOT_PASSWORD:-}" ]]; then
  echo "ERROR: MYSQL_ROOT_PASSWORD is not set. Define it in .env or export it before running." >&2
  exit 1
fi

# 네트워크 생성: 서비스 간 통신
docker network create egov-network || true

# 볼륨 생성: 데이터 영속성
docker volume create mysql-data || true

# MySQL 컨테이너 실행
docker run -d \
  --name mysql-db \
  --network egov-network \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD}" \
  -e MYSQL_DATABASE="${MYSQL_DATABASE}" \
  -e MYSQL_CHARSET=utf8mb4 \
  -e MYSQL_COLLATION=utf8mb4_unicode_ci \
  --health-cmd="mysql --protocol=TCP -h 127.0.0.1 -u root --password=\"${MYSQL_ROOT_PASSWORD}\" -e 'SELECT 1' || exit 1" \
  --health-interval=1s \
  --health-timeout=3s \
  --health-retries=60 \
  --health-start-period=3s \
  --restart=unless-stopped \
  "mysql:${MYSQL_VERSION}" \
  --character-set-server=utf8mb4 \
  --collation-server=utf8mb4_unicode_ci \
  --init-connect='SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci' \
  --default-time-zone=Asia/Seoul \
  --bind-address=0.0.0.0

# 앱 컨테이너 실행 (app 서비스)
docker run -d \
  --name egov-ebt \
  --network egov-network \
  -p 8080:8080 \
  -e Globals.Url="jdbc:log4jdbc:mysql://mysql-db:3306/${MYSQL_DATABASE}?useSSL=false" \
  -e Globals.UserName="${MYSQL_USER}" \
  -e Globals.Password="${MYSQL_ROOT_PASSWORD}" \
  --restart=unless-stopped \
  "egov-ebt:${EGOV_EBT_VERSION}"

# MySQL healthy 상태 확인 (depends_on 대체)
docker inspect --format "{{json .State.Health.Status }}" mysql-db
