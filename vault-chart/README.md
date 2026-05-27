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
  spring.data.mongodb.username=mongodb \
  spring.data.mongodb.password=dbmongo \
  spring.datasource.url="jdbc:postgresql://postgresql:5432/store_default" \
  spring.datasource.database=store_default \
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
