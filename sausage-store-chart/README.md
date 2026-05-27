# Chart

## Проверка

- **MongoDB**
 
    ```bash
    kubectl get pod -l app=mongodb
    kubectl get statefulset mongodb
    kubectl exec -it statefulset/mongodb -c mongodb -- mongosh -u mongodb -p dbmongo --authenticationDatabase admin --eval "db.adminCommand({ ping: 1 })"
    ```

- **PostgreSQL**

    ```bash
    kubectl get pod -l app=postgresql
    kubectl get statefulset postgresql
    kubectl exec -it statefulset/postgresql -c postgresql -- psql -U postgres -d store_default -c '\conninfo'
    ```
