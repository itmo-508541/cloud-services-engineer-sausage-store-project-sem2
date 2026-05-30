# Чарт `sausage-store-chart`

## Установка чарта

```bash
helm upgrade --install sausage-store ./sausage-store-chart \
  --history-max 3 \
  --set global.vault.token='<token>'
```

## Проверка

**MongoDB**
 
```bash
kubectl get pod -l app.kubernetes.io/component=mongodb
kubectl get statefulset mongodb

kubectl exec -it statefulset/mongodb -c mongodb -- sh -c \
  'mongosh -u "$(cat /run/secrets/mongo-root-username)" \
    -p "$(cat /run/secrets/mongo-root-password)" \
    --authenticationDatabase admin --eval \
    "db.adminCommand({ ping: 1 })"'

kubectl exec statefulset/mongodb -c mongodb -- sh -c \
  'mongosh -u "$(cat /run/secrets/mongo-root-username)" \
    -p "$(cat /run/secrets/mongo-root-password)" \
    --authenticationDatabase admin --eval \
    "db.getSiblingDB(\"sausage-store\").getUser(\"mngdbuser\")"'

kubectl exec statefulset/mongodb -c mongodb -- sh -c \
  'mongosh -u mngdbuser -p mngdbpsw1 sausage-store \
    --eval "db.runCommand({ ping: 1 })"'

kubectl exec statefulset/mongodb -c mongodb -- sh -c \
  'mongosh -u mngdbuser -p mngdbpsw1 sausage-store \
    --eval "db.reports.countDocuments()"'
```

**PostgreSQL**

```bash
kubectl get pod -l app.kubernetes.io/component=postgresql
kubectl get statefulset postgresql

kubectl exec -it statefulset/postgresql -c postgresql -- \
    psql -U postgres -d store_default -c '\conninfo'
```

**Backend Report**

```bash
kubectl get all -l app.kubernetes.io/name=backend-report
kubectl get deployment/sausage-store-backend-report

kubectl exec -it deployment/sausage-store-backend-report -c sausage-store-backend-report -- \
    cat /run/secrets/env

kubectl exec -it deployment/sausage-store-backend-report -c sausage-store-backend-report -- \
    env | grep CONFIG
```

**Backend**

```bash
kubectl get all -l app.kubernetes.io/name=backend
kubectl get deployment/sausage-store-backend

kubectl exec -it deployment/sausage-store-backend -c sausage-store-backend -- \
    env | grep SPRING
```

**Frontend**

```bash
kubectl get all -l app.kubernetes.io/name=frontend
kubectl get deployment/sausage-store-frontend

kubectl exec -it deployment/sausage-store-frontend -c sausage-store-frontend -- \
    cat /etc/nginx/nginx.conf
```
