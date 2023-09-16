#! /usr/bin/bash

for file in $(find . -name Vagrantfile); do
    CURRENT_DIR="$(pwd)"
    cd "$(dirname $file)"
    vagrant up
    cd "$CURRENT_DIR"
done
