#!/bin/sh

##Sample IPTABLE Config##
#/sbin/iptables -P INPUT DROP
#/sbin/iptables -A INPUT -s IP/SUBNET -j ACCEPT
#/sbin/iptables -A INPUT -p udp --dport 6000:60000 -j ACCEPT 
apk add asterisk-sample-config
if [ ! -d "/etc/asterisk" ]; then
  echo 1
elif [ -z "$(ls -A /etc/asterisk)" ]; then
  cp -rf /etc/sampleConfig/* /etc/asterisk/
fi
#exec "$@"

ASTERISK_USER=${ASTERISK_USER:-asterisk}
ASTERISK_GROUP=${ASTERISK_GROUP:-${ASTERISK_USER}}

if [ "$1" = "" ]; then
  COMMAND="/usr/sbin/asterisk -T -U ${ASTERISK_USER} -p -f"
else
  COMMAND="$@"
fi

if [ "${ASTERISK_UID}" != "" ] && [ "${ASTERISK_GID}" != "" ]; then

  deluser asterisk && \
  addgroup -g ${ASTERISK_GID} ${ASTERISK_GROUP} && \
  adduser -D -H -u ${ASTERISK_UID} -G ${ASTERISK_GROUP} ${ASTERISK_USER} \
  || exit
fi

chown -R ${ASTERISK_USER}: /var/log/asterisk \
                           /var/lib/asterisk \
                           /var/run/asterisk \
                           /etc/asterisk \
                           /var/spool/asterisk; \
exec ${COMMAND}