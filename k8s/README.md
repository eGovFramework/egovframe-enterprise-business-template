# Kubernetes 배포 가이드

egovframe-template-enterprise 를 Kubernetes 클러스터에 배포하는 절차입니다.

## 사전 요구사항

- Docker (이미지 빌드)
- `kubectl` (클러스터 접근 설정 완료)

> 이 애플리케이션은 Spring Boot 가 아닌 Tomcat WAR 배포판이라 ConfigMap/Secret 을 컨테이너
> 환경변수로 주입해도 `globals.properties` 값을 덮어쓰지 못합니다. DB 접속 정보(호스트/계정)는
> 이미지 빌드 시점의 `src/main/resources/egovframework/egovProps/globals.properties` 값
> (`mysql:3306/ebt`, 계정 `ebt`/`ebt01`)이 그대로 사용되며, 아래 `mysql-deployment.yaml` /
> `mysql-service.yaml` 은 이 값과 맞춰 Service 이름을 `mysql` 로 고정해 두었습니다. 다른
> 호스트/계정을 쓰려면 `globals.properties` 를 수정하고 이미지를 다시 빌드해야 합니다.

## 1. 이미지 빌드

프로젝트 루트에서 아래 명령을 실행합니다.

```bash
# WAR 빌드 및 Docker 이미지 생성
docker build -t egov-ebt:5.0.0 .
```

로컬 테스트가 아닌 클러스터 배포 시에는 레지스트리에 push합니다.

```bash
docker tag egov-ebt:5.0.0 <registry>/egov-ebt:5.0.0
docker push <registry>/egov-ebt:5.0.0
```

`deployment.yaml` 의 `image` 필드를 실제 레지스트리 경로로 수정합니다.

## 2. MySQL 시크릿 생성

`globals.properties` 에 baked-in 된 계정(`ebt`/`ebt01`)과 동일한 값으로 생성합니다.
클러스터 내부 MySQL 용 root/사용자 비밀번호는 Secret 으로 관리합니다.

```bash
kubectl create secret generic egov-ebt-mysql \
  --from-literal=root-password=<원하는_root_비밀번호> \
  --from-literal=password=ebt01
```

## 3. 초기 스키마/데이터 ConfigMap 생성

리포지토리에 포함된 DDL/DML을 그대로 사용해 MySQL 최초 기동 시 자동 적재되도록 ConfigMap 을
만듭니다(`/docker-entrypoint-initdb.d` 는 데이터 볼륨이 비어 있을 때 1회만 실행됩니다).
아래 명령은 프로젝트 루트에서 실행합니다.

```bash
kubectl create configmap egov-ebt-mysql-initdb \
  --from-file=DATABASE/mysql/all_ebt_ddl_mysql.sql \
  --from-file=DATABASE/mysql/all_ebt_data_mysql.sql
```

## 4. 매니페스트 적용

MySQL 을 먼저 올리고 앱을 적용합니다(앱 Pod 는 initContainer 로 MySQL 준비를 대기).

```bash
kubectl apply -f k8s/mysql-pvc.yaml
kubectl apply -f k8s/mysql-service.yaml
kubectl apply -f k8s/mysql-deployment.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

또는 디렉토리를 한 번에 적용합니다.

```bash
kubectl apply -f k8s/
```

외부(클러스터 밖) MySQL 을 쓰고 싶다면 `mysql-*.yaml` 세 파일 적용을 생략하고, 대신
`globals.properties` 의 `Globals.Url`/`UserName`/`Password` 를 해당 DB에 맞게 수정한 뒤
이미지를 다시 빌드합니다.

## 5. 접속

### ClusterIP (기본)

`service.yaml` 의 기본 타입은 `ClusterIP` 이며, 포트는 `8080` 입니다.  
클러스터 내부에서 `http://egov-ebt:8080` 으로 접근합니다.

### minikube (로컬 테스트)

```bash
# NodePort 로 타입 변경 후 적용
kubectl patch svc egov-ebt -p '{"spec":{"type":"NodePort"}}'

# 포트 포워딩으로 직접 접근
kubectl port-forward svc/egov-ebt 8080:8080
# 브라우저: http://localhost:8080
```

또는 minikube 터널을 사용합니다.

```bash
minikube service egov-ebt --url
```

## 6. 상태 확인

```bash
# Pod 상태 확인
kubectl get pods -l app.kubernetes.io/name=egov-ebt

# 로그 확인
kubectl logs -l app.kubernetes.io/name=egov-ebt --tail=100

# Deployment 상태
kubectl rollout status deployment/egov-ebt
```

Pod 가 `Running` 상태이고 `READY` 컬럼이 `1/1` 이면 정상입니다.  
readinessProbe(`GET /`, 포트 8080)가 성공해야 트래픽이 전달됩니다.

## 7. 삭제

```bash
kubectl delete -f k8s/
kubectl delete secret egov-ebt-mysql
kubectl delete configmap egov-ebt-mysql-initdb
```

## 매니페스트 구성 요약

| 파일 | 리소스 | 주요 설정 |
|---|---|---|
| `deployment.yaml` | Deployment `egov-ebt` | replicas: 1, image: `egov-ebt:5.0.0`, containerPort: 8080, initContainer로 MySQL 대기 |
| `service.yaml` | Service `egov-ebt` | type: ClusterIP, port: 8080 |
| `mysql-deployment.yaml` | Deployment `egov-ebt-mysql` | image: `mysql:8.0.39`, initdb ConfigMap/Secret 마운트 |
| `mysql-service.yaml` | Service `mysql` | type: ClusterIP, port: 3306 |
| `mysql-pvc.yaml` | PVC `mysql-data` | 2Gi, ReadWriteOnce |
