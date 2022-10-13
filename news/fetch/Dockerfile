FROM debian:stable-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        calibre \
        ca-certificates \
        git \
        s-nail &&\
    apt-get clean && rm -rf /var/apt/lists/* 
RUN useradd --user-group --shell /bin/false --create-home fetch_news

RUN mkdir /fetch && \
    chown fetch_news:fetch_news /fetch
    
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "docker-entrypoint.sh" ]

USER fetch_news
CMD /fetch/news/news.sh