FROM debian:stable-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        calibre \
        ca-certificates \
        git \
        s-nail &&\
    apt-get clean && rm -rf /var/apt/lists/* 
RUN useradd --user-group --shell /bin/false --create-home fetch_news

RUN git clone https://github.com/jakubchyla/news.git --depth 1 /news && \
    mkdir /news_output && \
    chown -R fetch_news:fetch_news /news /news_output

USER fetch_news
CMD /news/news.sh