Docker-Asterisk16
=================

Построение контейнера "Asterisk 16 LTS" для Docker

> Готовый images на [dockerhub](https://hub.docker.com/r/dachesnokov/asterisk16)

GET START CentOS
----------------

      # mkdir /var/docker
      # cd /var/docker
      # yum -y install git
      # git clone https://github.com/dachesnokov/Docker-Asterisk16.git
      # cd /var/docker/Docker-Asterisk16/centos7
      # chmod +x /var/docker/Docker-Asterisk16/centos7/build.sh
      # /var/docker/Docker-Asterisk16/centos7/build.sh
      # chmod +x /var/docker/Docker-Asterisk16/centos7/run.sh
      # /var/docker/Docker-Asterisk16/centos7/run.sh


BUILD
----

      # docker build -t "image id" .

HELP
----

Войти в bash / asterisk cli

      # docker exec -it "conteiner id" /bin/bash
      # docker exec -it "conteiner id" asterisk -rvvv

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
