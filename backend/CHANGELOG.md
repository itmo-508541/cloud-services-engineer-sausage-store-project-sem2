# Changelog

Все заметные изменения в этом проекте будут задокументированы в этом файле.

Формат файла основан на [Keep a Changelog](https://keepachangelog.com/ru/1.1.0/), этот проект придерживается [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.1]

### Added

- Добавлены [миграции](src/main/resources/db/migration/) для базы данных
- Добавлены serial sequence для таблиц `orders` и `product`

### Changed

- Изменён базовый образ для целевого контейнера на `openjdk:16-ea-jdk-alpine`

### Removed

- Удалены секретные данные из файла [application.properties](src/main/resources/application.properties)

## [0.1.0]

### Added

- Добавлены файлы финального задания
