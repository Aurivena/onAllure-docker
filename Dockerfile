FROM alpine:latest

# Устанавливаем необходимые пакеты
RUN apk add --no-cache \
    openjdk11 \
    wget \
    tar \
    bash

RUN apk add --no-cache wget tar bash

# Устанавливаем переменные среды для Java
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Загружаем и распаковываем Allure
RUN wget https://github.com/allure-framework/allure2/releases/download/2.23.0/allure-2.23.0.tgz && \
    tar -zxvf allure-2.23.0.tgz && \
    mv allure-2.23.0 /opt/allure && \
    ln -s /opt/allure/bin/allure /usr/local/bin/allure

# Устанавливаем переменные среды для Allure
ENV PATH="/opt/allure/bin:${PATH}"

COPY scripts/ /app/scripts/
RUN chmod +x /app/scripts/*

WORKDIR /app
