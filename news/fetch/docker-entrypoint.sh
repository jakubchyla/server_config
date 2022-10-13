#! /bin/sh

set -e

rm -rf /fetch/news
git clone https://github.com/jakubchyla/news.git --depth 1 /fetch/news
mkdir /fetch/news/output

set +e
exec "$@"
