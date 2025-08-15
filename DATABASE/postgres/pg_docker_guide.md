
# 🐘 PostgreSQL 환경으로 Docker 실행 가이드

전자정부 표준프레임워크 프로젝트를 PostgreSQL 데이터베이스와 함께 Docker로 실행하는 방법을 안내합니다.

## 📋 목차

1. [사전 준비사항](#사전-준비사항)
2. [프로젝트 설정 변경](#프로젝트-설정-변경)
3. [Docker 환경 실행](#docker-환경-실행)
4. [데이터베이스 초기화](#데이터베이스-초기화)
5. [접속 정보](#접속-정보)
6. [문제 해결](#문제-해결)

## 🔧 사전 준비사항

- Docker 및 Docker Compose 설치
- Git을 통한 프로젝트 클론 완료

## ⚙️ 프로젝트 설정 변경

### 1. globals.properties 파일 수정

`src/main/resources/egovframework/egovProps/globals.properties` 파일에서:

```properties
# 기존
Globals.DbType = mysql

# 변경
Globals.DbType = postgres
```

### 2. pom.xml 파일 수정

`/pom.xml` 파일에서 postgresql 드라이버 depencency 주석을 해제 합니다.
```xml
		<!-- postgres driver -->
		<dependency>
			<groupId>org.postgresql</groupId>
			<artifactId>postgresql</artifactId>
			<version>42.7.1</version>
		</dependency>
```


### 3. docker-compose.yml 파일 교체

기존 `docker-compose.yml` 파일을 다음 내용으로 변경:

```yaml
services:
  app:
    build: .
    image: egov-ebt:4.3.0
    container_name: egov-ebt
    ports:
      - "8080:8080"
    environment:
      - Globals.Url=jdbc:postgresql://postgres-db:5432/postgres?currentSchema=ebt
      - Globals.DriverClassName=org.postgresql.Driver
      - Globals.DbType=postgres
      - Globals.MapperDbType=postgres
      - Globals.UserName=postgres
      - Globals.Password=admin
    depends_on:
      postgres-db:
        condition: service_healthy
    restart: unless-stopped

  postgres-db:
    image: postgres:15
    container_name: postgres-db
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: admin
      POSTGRES_DB: postgres
      TZ: Asia/Seoul
    volumes:
      - postgres-data:/var/lib/postgresql/data
      - ./DATABASE/postgres/all_ebt_ddl_postgres.sql:/docker-entrypoint-initdb.d/01_ddl.sql:ro
      - ./DATABASE/postgres/all_ebt_data_postgres.sql:/docker-entrypoint-initdb.d/02_data.sql:ro
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres -d postgres"]
      interval: 1s
      timeout: 3s
      retries: 60
      start_period: 3s
    restart: unless-stopped

volumes:
  postgres-data: {}
```

## 🚀 Docker 환경 실행

### 1. Docker 컨테이너 빌드 및 실행

```bash
# PostgreSQL 환경으로 실행(최초)
docker compose up --build -d

# 이후 컨테이너만 실행
docker compose up -d
```

### 2. 실행 상태 확인

```bash
# 컨테이너 상태 확인
docker compose ps

# 로그 확인
docker compose logs -f
```

### 3. 컨테이너 중지

```bash
# 컨테이너 상태 확인
docker compose down

# 로그 확인
docker compose logs -f
```

## 🗃️ 데이터베이스 초기화

### ✅ 자동 초기화 (권장)

Docker Compose 설정에 포함된 개별 파일 마운트를 통해 **자동으로 초기화**됩니다:
- DDL 파일: `./DATABASE/postgres/all_ebt_ddl_postgres.sql:/docker-entrypoint-initdb.d/01_ddl.sql:ro`
- 데이터 파일: `./DATABASE/postgres/all_ebt_data_postgres.sql:/docker-entrypoint-initdb.d/02_data.sql:ro`

PostgreSQL 컨테이너 최초 실행 시 다음 파일들이 자동 실행됩니다:
1. `DATABASE/postgres/all_ebt_ddl_postgres.sql` - 스키마 및 테이블 생성
2. `DATABASE/postgres/all_ebt_data_postgres.sql` - 초기 데이터 입력

### 🔧 수동 초기화 (필요시)

postgresql 을 DB 클라이언트 툴로 접속후 sql문 직접 실행:

1. `DATABASE/postgres/all_ebt_ddl_postgres.sql` - 스키마 및 테이블 생성
2. `DATABASE/postgres/all_ebt_data_postgres.sql` - 초기 데이터 입력


## 🌐 접속 정보

### 웹 애플리케이션
- **URL**: http://localhost:8080
- **관리자 계정**:
  - 아이디: `admin`
  - 비밀번호: `1`

### PostgreSQL 데이터베이스
- **호스트**: `localhost`
- **포트**: `5432`
- **데이터베이스**: `postgres`
- **스키마**: `ebt`
- **사용자**: `postgres`
- **비밀번호**: `admin`


### 유용한 명령어

```bash
# 환경 중지
docker compose down

# 환경 중지 및 볼륨 완전 삭제
docker compose down -v

# 이미지 재빌드 실행
docker compose up --build -d
```

---
