# Chart

## Проверка

- MongoDB
 
    ```bash
    kubectl get pod -l app=mongodb
    kubectl get statefulset mongodb
    kubectl exec -it statefulset/mongodb -c mongodb -- mongosh -u mongodb -p dbmongo --authenticationDatabase admin --eval "db.adminCommand({ ping: 1 })"
    ```
