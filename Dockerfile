#
# Dockerfile for shoutcast
#
# VERSION               0.1

FROM debian:jessie-slim

MAINTAINER Riftbit ErgoZ <ergozru@riftbit.com>

WORKDIR /opt/shoutcast

# Prepare APK CDNs
RUN apt-get update && \
    apt-get install curl tar gzip && \
    && curl http://download.nullsoft.com/shoutcast/tools/sc_serv2_linux_x64-latest.tar.gz | tar xz && \
    rm sc_serv2_linux_x64-latest.tar.gz && \
    mkdir -p control logs && \
    && apt-get purge --auto-remove -y curl tar gzip && \
    && rm -rf /var/lib/apt/lists/*

COPY sc_serv.conf .

#do not forget about /opt/shoutcast/sc_serv.conf
VOLUME ["/opt/shoutcast/logs"]

EXPOSE 8000:8000/tcp 8001:8001/tcp

CMD ["./sc_serv", "sc_serv.conf"]
