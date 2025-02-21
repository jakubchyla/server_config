#! /usr/bin/env sh

kubectl -n discord-calendar exec -it deployments/discord-calendar-deployment -c discord-calendar-nginx -- sh
