#! /bin/sh

set -e

chown -R syncthing:syncthing /syncthing_data

set +e
exec gosu syncthing "$@"
