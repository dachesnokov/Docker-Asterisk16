#!/bin/bash
chown -R asterisk:asterisk /etc/asterisk/
chown -R asterisk:asterisk /var/{lib,log,spool}/asterisk
chown -R asterisk:asterisk /usr/lib64/asterisk/
asterisk -U asterisk
sleep 5
asterisk -r
