#! /usr/bin/env sh

kubectl -n discord-calendar delete deployments.apps discord-calendar-deployment && \
kubectl apply -f deployment.yaml
