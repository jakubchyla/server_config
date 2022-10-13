FROM debian:stable-slim

RUN apt-get update && apt-get install -y  \
        exim4-daemon-light && \
    apt-get clean && rm -rf /var/apt/lists/* 

RUN mkdir -p /var/spool/exim4 /var/log/exim4 && \
    chown Debian-exim:Debian-exim /var/spool/exim4 /var/log/exim4

# exim4 configuration
VOLUME [ "/config" ]

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD exim -bd -v
