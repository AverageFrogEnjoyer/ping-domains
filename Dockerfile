FROM ubuntu:latest

# Установка ping и других зависимостей
RUN apt-get update && \
    apt-get install -y iputils-ping curl && \
    apt-get clean

# Копирование списка доменов и скрипта в контейнер
COPY ./domains.txt /domains.txt
COPY ./ping_domains.sh /ping_domains.sh

# Установка прав на выполнение для скрипта
RUN chmod +x /ping_domains.sh

# Запуск скрипта
CMD ["/bin/bash", "/ping_domains.sh"]
