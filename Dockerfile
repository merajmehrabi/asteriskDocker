FROM alpine:latest
#MAINTAINER Meraj Mehrabi merajmehrabi@gmail.com
USER root
RUN apk add --update \
      asterisk \
      asterisk-sample-config \
      asterisk-sounds-en \
#      iptables \
&& asterisk -U asterisk \
&& sleep 5 \
&& pkill -9 asterisk \
&& pkill -9 astcanary \
&& sleep 2 \
&& rm -rf /var/run/asterisk/* \
&& mkdir -p /var/spool/asterisk/fax \
&& chown -R asterisk: /var/spool/asterisk/fax \
&& truncate -s 0 /var/log/asterisk/messages \
                 /var/log/asterisk/queue_log \
&&  rm -rf /var/cache/apk/* \
           /tmp/* \
           /var/tmp/*

RUN mv /etc/asterisk /etc/sampleConfig

EXPOSE 5060/udp 5060/tcp
VOLUME /var/lib/asterisk/sounds /var/lib/asterisk/keys /var/lib/asterisk/phoneprov /var/spool/asterisk /var/log/asterisk /etc/asterisk

ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]