#! /bin/sh

chown -R syncthing:syncthing /syncthing_data
exec gosu syncthing "$@"