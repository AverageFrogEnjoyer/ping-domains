#!/bin/bash

CONTAINER_NAME="ping-container"
IMAGE_NAME="ping-container"

# Проверяем, существует ли контейнер, и если да, то удаляем его
if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    echo "Контейнер $CONTAINER_NAME существует. Удаляю его..."
    docker rm -f $CONTAINER_NAME
fi

# Создаем образ Docker
echo "Создаю образ $IMAGE_NAME..."
docker build -t $IMAGE_NAME .

# Запускаем контейнер
echo "Запускаю контейнер..."
docker run --name $CONTAINER_NAME $IMAGE_NAME

# Проверяем статус контейнера
if [ "$(docker ps -a -q -f name=$CONTAINER_NAME -f status=exited)" ]; then
    echo "Контейнер $CONTAINER_NAME успешно запущен."
else
    echo "Ошибка: Контейнер $CONTAINER_NAME не запустился!"
    exit 1
fi

# Записываем логи в текстовый файл
LOG_FILE="ping_results.log"
echo "Сохраняю логи контейнера $CONTAINER_NAME в файл $LOG_FILE..."
docker logs $CONTAINER_NAME > $LOG_FILE

echo "Логи контейнера сохранены в файл $LOG_FILE."
