#!/bin/bash
docker run \
 -v ./etc/asterisk:/etc/asterisk \
 -v ./var/log/asterisk:/var/log/asterisk \
 --name pbx \
 -h pbx \
 --net=host \
 --restart=always \
 -i -t "dachesnokov/asterisk16:centos7"
