#! /bin/sh

set -e

# copy and update config 
cp /config/* /etc/exim4/
chown root:Debian-exim /etc/exim4/passwd.client
chmod 640 /etc/exim4/passwd.client
ln -fs /etc/hostname /etc/mailname
update-exim4.conf

set +e
exec "$@"
