# Настройка Vault

## Установка чарта

Установить и перейти в консоль пода:

```bash
helm uninstall vault
helm install vault ./vault-chart
kubectl exec -it deploy/vault -- sh
```

В консоли пода выполнить:

```sh
vault operator init    # записать Unseal ключи и Initial Root Token
vault operator unseal  # вставить 3 раза и вписать 3 из 5 `Unseal Key` по очереди
vault login
vault secrets list
vault secrets enable -path=kv kv-v2
```

Заполнить необходимые для работы приложения значения

```sh
vault kv put kv/sausage-store \
  spring.data.mongodb.uri="mongodb://mongodb:dbmongo@mongodb:27017/sausage-store?authSource=admin" \
  mongodb.init.username=mongodb \
  mongodb.init.password=dbmongo \
  spring.datasource.url="jdbc:postgresql://postgresql:5432/store_default" \
  postgresql.init.database=store_default \
  spring.datasource.username=postgres \
  spring.datasource.password=postgres

vault kv get kv/sausage-store
vault kv get -mount=kv -field=spring.datasource.username sausage-store

vault policy write sausage-store-read - <<EOF
path "kv/data/sausage-store" {
  capabilities = ["read"]
}
EOF

vault token create -policy=sausage-store-read -ttl=768h
```

Веб-интерфейс

- `kubectl port-forward deploy/vault 8200:8200`
- По адресу http://localhost:8200/ui/ будет UI

## Начать всё заново

```bash
kubectl delete all,pvc,secret,configmap,ingress,vpa,hpa --all
```

## Проверка квот

```bash
kubectl describe resourcequota
```

Использование квот после деплоя суб-чарта frontend:

```plain
Name:                   r-devops-magistracy-project-2sem-1130000019267475-quota
Namespace:              r-devops-magistracy-project-2sem-1130000019267475
Resource                Used    Hard
--------                ----    ----
configmaps              4       10
limits.cpu              2100m   3
limits.memory           1664Mi  2500Mi
persistentvolumeclaims  3       4
pods                    6       10
requests.cpu            800m    2
requests.memory         832Mi   1000Mi
requests.storage        2560Mi  5Gi
secrets                 6       10
services                5       7
services.loadbalancers  0       0
services.nodeports      0       0
```
