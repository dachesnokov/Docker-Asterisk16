FROM dachesnokov/centos7-asterisk16lts

ADD start_aster.sh /start_aster.sh

RUN chmod +x /start_aster.sh

CMD ["/start_aster.sh"]
