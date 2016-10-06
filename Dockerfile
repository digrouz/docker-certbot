# vim:set ft=dockerfile:
FROM alpine:latest
MAINTAINER DI GREGORIO Nicolas <nicolas.digregorio@gmail.com>

### Environment variables
ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm' 

### Install Application
RUN apk --no-cache upgrade && \
    apk add --no-cache --virtual=run-deps \
      certbot && \
    rm -rf /tmp/* \
           /var/cache/apk/*  \
           /var/tmp/*

### Volume
VOLUME ["/certs"]

### Expose ports
#EXPOSE 5050

### Running User: not used, managed by docker-entrypoint.sh
#USER nginx

### Start certbot
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["certbot"]
