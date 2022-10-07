FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
        syncthing \
        gosu && \
    apt-get clean && rm -rf /var/apt/lists/* && \
    gosu nobody true
RUN useradd --user-group --shell /bin/false --create-home syncthing

VOLUME "/syncthing_data"

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "docker-entrypoint.sh" ]

EXPOSE 8384/tcp 22000/tcp 22000/udp 21027/udp

CMD syncthing -no-browser -no-restart -gui-address=0.0.0.0:8384 -home=/syncthing_data