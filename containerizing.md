# Containerizing

## App 빌드
```shell
docker build -t egov-ebt:4.3.0 .
```

* ARM 기반(예: Apple Silicon)에서 빌드할 때는 멀티 플랫폼을 지원하도록 buildx를 사용하세요.
```shell
docker buildx build \
--platform linux/amd64,linux/arm64 \
-t egov-ebt:4.3.0 .
```

### [참고] Docker로 단독 실행 (테스트용)
```shell
docker run -p 8080:8080 egov-ebt:4.3.0
```

## docker-compose에서 서비스 실행
```shell
# Database(mysql)만 먼저 실행 (DB 초기화 준비)
docker compose up -d mysql-db

# App 실행 (depends_on으로 DB healthy 상태 대기)
docker compose up -d app

# 모든 서비스를 한 번에 실행 (백그라운드 추천)
docker compose up -d
```

## [주의] 최초 실행 시 DB 초기화 세팅
- docker-compose.yml에 SQL 파일 volumes가 없으므로 자동 초기화되지 않습니다.
- DB 컨테이너를 먼저 실행한 후 DB Tool을 사용해서 DDL/DML을 수동으로 실행하세요.

## 볼륨 제거 (초기화)
```shell
docker-compose down -v
```
- 이 명령으로 mysql-data 볼륨을 삭제하여 DB를 초기화합니다. 재시작 전에 사용하세요.


## 🐘 PostgreSQL 환경 실행

PostgreSQL 환경으로 전환하기 위해 다음 설정을 변경해야 합니다.

#### 1. globals.properties 파일 수정

`src/main/resources/egovframework/egovProps/globals.properties` 파일에서:

```properties
# 기존
Globals.DbType = mysql

# 변경
Globals.DbType = postgres
```

#### 2. pom.xml 파일 수정

`/pom.xml` 파일에서 postgresql 드라이버 dependency 주석을 해제합니다:
```xml
		<!-- postgres driver -->
		<dependency>
			<groupId>org.postgresql</groupId>
			<artifactId>postgresql</artifactId>
			<version>42.7.1</version>
		</dependency>
```

#### 3. docker-compose.yml 파일 교체

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

### 🚀 PostgreSQL 환경 실행

#### 1. Docker 컨테이너 빌드 및 실행

```bash
# PostgreSQL 환경으로 실행(최초)
docker compose up --build -d

# 이후 컨테이너만 실행
docker compose up -d
```

#### 2. 실행 상태 확인

```bash
# 컨테이너 상태 확인
docker compose ps

# 로그 확인
docker compose logs -f
```

#### 3. 컨테이너 중지

```bash
# 컨테이너 중지
docker compose down

# 환경 중지 및 볼륨 완전 삭제
docker compose down -v

# 이미지 재빌드 실행
docker compose up --build -d
```

## 🌐 접속 정보

### 웹 애플리케이션
- **URL**: http://localhost:8080
- **관리자 계정**:
  - 아이디: `admin`
  - 비밀번호: `1`


## JVM 메모리 및 성능 옵션 설명

이 문서는 Dockerfile의 `ENV JAVA_TOOL_OPTIONS`를 기반으로 Docker 컨테이너 환경에서 유용한 JVM 옵션을 요약합니다. 각 옵션은 메모리 관리, GC 최적화, 디버깅을 위해 설계되었습니다.

### 1. 메모리 비율 설정
- **`-XX:MaxRAMPercentage=60.0`**  
  JVM이 컨테이너에 할당된 전체 메모리의 60%를 최대 힙 크기로 사용합니다. (Java 8u191+ 지원)  
  *장점*: 동적 메모리 조정으로 OutOfMemoryError(OOM) 방지.

### 2. 가비지 컬렉터(GC)
- **`-XX:+UseG1GC`**  
  G1 GC를 사용합니다. (Java 8+ 추천, 저지연 애플리케이션에 적합)  
  *장점*: 대형 힙에서 효율적이며, 애플리케이션 지연 최소화.

### 3. 메모리 부족 대응
- **`-XX:+HeapDumpOnOutOfMemoryError`**  
  OOM 발생 시 힙 덤프 파일을 생성합니다. (디버깅 유용)  
  *장점*: 문제 발생 시 메모리 상태 분석에 활용.

### 4. 보안 및 랜덤 소스 최적화
- **`-Djava.security.egd=file:/dev/./urandom`**  
  SecureRandom 생성 지연을 방지합니다. (랜덤 소스를 /dev/urandom으로 변경)  
  *장점*: 컨테이너 환경에서 암호화 작업 속도 향상.

### 추가 팁
- **적용 방법**: Dockerfile에서 이미 설정된 대로 사용하세요.  
  예:
  ```dockerfile
  ENV JAVA_TOOL_OPTIONS="\
    -XX:MaxRAMPercentage=60.0 \
    -XX:+UseG1GC \
    -XX:+HeapDumpOnOutOfMemoryError \
    -Djava.security.egd=file:/dev/./urandom"
  ```
- **주의**: Java 버전(Tomcat 9.0-jre8 기반)과 컨테이너 메모리 제한에 따라 조정하세요. OOM 시 퍼센트 값을 70-80%로 높여보세요.
- **참고**: 로그 확인: `docker logs egov-ebt`.
