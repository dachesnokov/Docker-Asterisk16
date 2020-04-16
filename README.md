Docker-Asterisk16
=================

Построение контейнера "Asterisk 16 LTS" для Docker

[![Build Status]()]()

> Репозиторий на [dockerhub](https://hub.docker.com/u/dachesnokov)

BUILD
----

      #  docker build -t "image id" .

HELP
----

Войти в bash

      # docker exec -it "conteiner id" /bin/bash

Создать volume на host-docker

      # docker volume create -d local --name "volume id"

Скопировать конфиги Asterisk в volume на host-docker

      # cp /etc/asterisk/* /var/lib/docker/"volume id"/asterisk/

Применить конфигурацию Asterisk

    # docker exec -it "conteiner id" asterisk -rx "dialplan reload"
      или так
    # docker exec -it "conteiner id" /bin/bash
    # asterisk -rvvv
    # {sip, dialplan} reload
