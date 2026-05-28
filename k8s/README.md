# Kubernetes 배포 가이드

egovframe-template-enterprise 를 Kubernetes 클러스터에 배포하는 절차입니다.

## 사전 요구사항

- Docker (이미지 빌드)
- `kubectl` (클러스터 접근 설정 완료)
- MySQL 8.x 또는 MariaDB 10.x 데이터베이스 (클러스터 내부 또는 외부)

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

## 2. 시크릿 생성

DB 접속 정보는 Secret 으로 관리합니다. 배포 전에 반드시 생성해야 합니다.

```bash
kubectl create secret generic egov-ebt-db \
  --from-literal=username=<DB_사용자명> \
  --from-literal=password=<DB_비밀번호>
```

## 3. ConfigMap 수정 (선택)

`configmap.yaml` 에서 DB 접속 URL을 환경에 맞게 수정합니다.

```yaml
data:
  Globals.Url: "jdbc:log4jdbc:mysql://<호스트>:3306/<DB명>?useSSL=false"
```

## 4. 매니페스트 적용

```bash
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

또는 디렉토리를 한 번에 적용합니다.

```bash
kubectl apply -f k8s/
```

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
kubectl delete secret egov-ebt-db
```

## 매니페스트 구성 요약

| 파일 | 리소스 | 주요 설정 |
|---|---|---|
| `deployment.yaml` | Deployment `egov-ebt` | replicas: 1, image: `egov-ebt:5.0.0`, containerPort: 8080 |
| `service.yaml` | Service `egov-ebt` | type: ClusterIP, port: 8080 |
| `configmap.yaml` | ConfigMap `egov-ebt` | Globals.Url (DB 접속 URL) |
