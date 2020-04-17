#!/bin/bash
docker run \
 -v /var/docker/Docker-Asterisk16/centos7/etc/asterisk:/etc/asterisk \
 -v /var/docker/Docker-Asterisk16/centos7/var/log/asterisk:/var/log/asterisk \
 --name pbx \
 -h pbx \
 --net=host \
 --restart=always \
 -i -t "dachesnokov/asterisk16:centos7"
