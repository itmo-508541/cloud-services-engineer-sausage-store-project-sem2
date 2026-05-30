# Chart

## Проверка

**MongoDB**
 
```bash
kubectl get pod -l app=mongodb
kubectl get statefulset mongodb
kubectl exec -it statefulset/mongodb -c mongodb -- \
    mongosh -u mongodb -p dbmongo --authenticationDatabase admin --eval "db.adminCommand({ ping: 1 })"
```

**PostgreSQL**

```bash
kubectl get pod -l app=postgresql
kubectl get statefulset postgresql
kubectl exec -it statefulset/postgresql -c postgresql -- \
    psql -U postgres -d store_default -c '\conninfo'
```

**Backend Report**

```bash
kubectl get deployment/sausage-store-backend-report
kubectl exec -it deployment/sausage-store-backend-report -c sausage-store-backend-report -- \
    cat /run/secrets/env
kubectl exec -it deployment/sausage-store-backend-report -c sausage-store-backend-report -- \
    env

kubectl exec statefulset/mongodb -c mongodb -- \
    mongosh "mongodb://mongodb:dbmongo@127.0.0.1:27017/sausage-store?authSource=admin" \
    --quiet --eval 'db.reports.countDocuments()'
```

**Backend**

```bash
kubectl get deployment/sausage-store-backend
kubectl exec -it deployment/sausage-store-backend -c sausage-store-backend -- \
    env
```

**Frontend**

```bash
kubectl get deployment/sausage-store-frontend
```
