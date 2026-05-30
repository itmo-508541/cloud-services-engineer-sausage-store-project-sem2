# Интернет-магазин «[Сосисочная](https://front-amindubaev.2sem.students-projects.ru/)»

![image](https://user-images.githubusercontent.com/9394918/121517767-69db8a80-c9f8-11eb-835a-e98ca07fd995.png)

## Использованные технологии

* Frontend – TypeScript, Angular.
* Backend  – Java 16, Spring Boot, Spring Data.
* Database – PostgreSQL, MongoDB.

## Подготовка к первому деплою приложения

HashiCorp Vault должен быть установлен в текущем namespace, он должен быть доступен по адресу http://vault:8200

- Для настройки Vault нужно воспользоваться [инструкцией](vault-chart/README.md)

## Деплой приложения

После `git push origin main` приложение автоматически будет выложено в k8s кластер.

- Для деплоя приложения и ручной проверки нужно воспользоваться [инструкцией](sausage-store-chart/README.md)

## Релиз новой версии приложения

После выпуска новой версии одного из образов приложения следует добавить информацию в CHANGELOG соответствующего образа [backend](backend/CHANGELOG.md), [backend-report](backend-report/CHANGELOG.md) или [frontend](frontend/CHANGELOG.md), и записать номер версии в Chart пода [backend](sausage-store-chart/charts/backend/Chart.yaml), [frontend](sausage-store-chart/charts/backend-report/Chart.yaml) или [frontend](sausage-store-chart/charts/frontend/Chart.yaml).

## Требования к локальному окружению разработчика

* **OS**: Linux
* **Docker**: 20.10+
* **Docker Compose**

## Запуск приложения

Для локальной разработки скопируйте файл `docker-compose.override.yml.dist` в `docker-compose.override.yml`. Этот файл подключается автоматически и переопределяет образы сервисов на сборку из исходников в каталогах `frontend` и `backend`. Без копирования контейнеры поднимаются с готовыми образами из реестра.

Для сборки и запуска приложения нужно выполнить `docker compose up -d --build`

После запуска приложение доступно по адресу http://localhost/.

## Запуск приложения из собранных образов

После первого успешного деплоя файл `docker-compose.override.yml` можно удалить, при отсутсвии этого файла, приложение будет запускаться из собранных образов из Docker Hub.

Для запуска приложения нужно выполнить `docker compose up -d`
