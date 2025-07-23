#!/usr/bin/env bash
# Docker 실행

# 네트워크 생성: 서비스 간 통신
docker network create egov-network

# 볼륨 생성: 데이터 영속성
docker volume create mysql-data

# MySQL 컨테이너 실행
docker run -d \
  --name mysql-db \
  --network egov-network \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=admin \
  -e MYSQL_DATABASE=ebt \
  -e MYSQL_CHARSET=utf8mb4 \
  -e MYSQL_COLLATION=utf8mb4_unicode_ci \
  --health-cmd="mysql --protocol=TCP -h 127.0.0.1 -u root --password=admin -e 'SELECT 1' || exit 1" \
  --health-interval=1s \
  --health-timeout=3s \
  --health-retries=60 \
  --health-start-period=3s \
  --restart=unless-stopped \
  mysql:8.0 \
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
  -e Globals.Url="jdbc:log4jdbc:mysql://mysql-db:3306/ebt?useSSL=false" \
  -e Globals.UserName=root \
  -e Globals.Password=admin \
  --restart=unless-stopped \
  egov-ebt:4.3.0

# MySQL healthy 상태 확인 (depends_on 대체)
docker inspect --format "{{json .State.Health.Status }}" mysql-db
