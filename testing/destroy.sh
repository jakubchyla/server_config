#! /usr/bin/bash

for file in $(find . -name Vagrantfile); do
    CURRENT_DIR="$(pwd)"
    cd "$(dirname $file)"
    vagrant destroy --force
    rm -rf .vagrant
    cd "$CURRENT_DIR"
done
