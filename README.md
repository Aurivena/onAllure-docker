#### Для запуска требуется сам docker

### Самое главное
Укажите в docker-compose.yml абсолютный путь до проекта

### Предисловие
В репозитории где тесты прописываем команду 
```shell
go test ./...
```

### Шаги для полноценной работы с контейнером (В этом репозитории)

### Шаг 1
```shell
make restart
```

### Шаг 2
```shell
docker exec -it allure-container sh
```

### Шаг 3
```shell
cd scripts
./allure.sh
```
