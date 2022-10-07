FROM debian:stable-slim

RUN apt-get update && apt-get install -y  \
        exim4-daemon-light && \
    apt-get clean && rm -rf /var/apt/lists/* 

RUN mkdir -p /var/spool/exim4 /var/log/exim4 && \
    chown Debian-exim:Debian-exim /var/spool/exim4 /var/log/exim4

# exim4 configuration
COPY mail_config/* /etc/exim4/
RUN chown root:Debian-exim /etc/exim4/passwd.client && \
    chmod 640 /etc/exim4/passwd.client && \
    ln -fs /etc/hostname /etc/mailname && \
    update-exim4.conf

CMD exim -bd -v