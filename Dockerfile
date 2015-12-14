FROM alpine:3.2
MAINTAINER Jan Broer <janeczku@yahoo.com>

##
## RootFS
##

COPY rootfs /

##
## Add Bind-tools
##

RUN apk-install bind-tools

##
## S6 Overlay
##

ENV S6_VERSION v1.16.0.2

ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz

##
## Go-dnsmasq
##

ADD https://github.com/janeczku/go-dnsmasq/releases/download/0.9.8/go-dnsmasq-min_linux-amd64 /usr/sbin/go-dnsmasq
RUN tar xvfz /tmp/s6-overlay.tar.gz -C / && \
  chmod 755 /usr/sbin/go-dnsmasq && \
  rm -rf /tmp/*

##
## INIT
##

ENTRYPOINT ["/init"]