#!/bin/bash
docker run \
 -v /var/docker/Docker-Asterisk16/centos7/etc/asterisk:/etc/asterisk \
 -v /var/docker/Docker-Asterisk16/centos7/var/log/asterisk:/var/log/asterisk \
 --name pbx \
 -h pbx \
 -p 10000-15000:10000-15000/udp \
 -p 5060:5060/udp \
 -p 5061:5061/udp \
 --restart=always \
 -i -t "dachesnokov/asterisk16:centos7"
