#
# Dockerfile for shoutcast
#
# VERSION               0.1

FROM alpine:latest

MAINTAINER Riftbit ErgoZ <ergozru@riftbit.com>

WORKDIR /opt/shoutcast

# Prepare APK CDNs
RUN apk update && apk upgrade && \
    apk add --update wget tar gzip && \
    wget http://download.nullsoft.com/shoutcast/tools/sc_serv2_linux_x64-latest.tar.gz && \
    tar zxf sc_serv2_linux_x64-latest.tar.gz && \
    rm sc_serv2_linux_x64-latest.tar.gz && \
    mkdir -p control logs \
    apk del wget tar gzip && \
    rm -rf /var/cache/apk/*

COPY sc_serv.conf .

VOLUME [ "/opt/shoutcast/sc_serv.conf", "/opt/shoutcast/logs"]

EXPOSE 8000:8000/tcp 8001:8001/tcp

CMD ["./sc_serv", "sc_serv.conf"]
