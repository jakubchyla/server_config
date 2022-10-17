#! /bin/sh

set -e

mkdir -p /syncthing/data /syncthing/config
chown -R syncthing:syncthing /syncthing

set +e
exec gosu syncthing "$@"
