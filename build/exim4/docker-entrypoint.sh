#! /bin/sh

set -e

# copy and update config 
exim4-configure.py --smarthost "$SMARTHOST" --relay-domains "$RELAY_DOMAINS" > /etc/exim4/update-exim4.conf.conf

# check if passwd.client exists, might be not needed
if [ -f "/config/passwd.client" ]; then
    cp /config/passwd.client /etc/exim4
    chown root:Debian-exim /etc/exim4/passwd.client
    chmod 640 /etc/exim4/passwd.client
else
    printf "%s\n" "no passwd.client, proceeding without it"
fi

ln -sf /etc/hostname /etc/mailname
update-exim4.conf

set +e
exec "$@"
