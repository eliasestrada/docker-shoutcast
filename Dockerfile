#
# Dockerfile for shoutcast
#
# VERSION               0.1

FROM alpine:latest

MAINTAINER Riftbit ErgoZ <ergozru@riftbit.com>

WORKDIR /opt/shoutcast

# Prepare APK CDNs
RUN DIR=$(mktemp -d) && cd ${DIR} && \
    apk update && apk upgrade && \
    apk add --update wget tar gzip && \
    mkdir -p /opt/cld2ch && \
    wget http://download.nullsoft.com/shoutcast/tools/sc_serv2_linux_x64-latest.tar.gz && \
    tar zxf sc_serv2_linux_x64-latest.tar.gz && \
    mkdir -p control logs \
    apk del wget tar bzip2 gzip ca-certificates curl && \
    rm -rf /var/cache/apk/*

COPY sc_serv.conf .

EXPOSE 8000 8001

CMD ["./sc_serv", "sc_serv.conf"]
