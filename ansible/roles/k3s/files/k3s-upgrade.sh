#!/bin/bash

# Define the URLs for the k3s binary and the checksum file
K3S_BINARY_URL="https://github.com/rancher/k3s/releases/latest/download/k3s"
K3S_CHECKSUM_URL="https://github.com/rancher/k3s/releases/latest/download/sha256sum-amd64.txt"

# Define the local paths for the binary and the checksum file
K3S_LOCAL_BINARY="/usr/local/bin/k3s"
K3S_DOWNLOAD_BINARY="/tmp/k3s"
K3S_DOWNLOAD_CHECKSUM_FILE="/tmp/k3s.sha256"

# Download the k3s binary
wget -O "$K3S_DOWNLOAD_BINARY" "$K3S_BINARY_URL"

# Download the checksum file
wget -O "$K3S_DOWNLOAD_CHECKSUM_FILE" "$K3S_CHECKSUM_URL"

# Get downloaded k3s binary checksum
K3S_DOWNLOAD_CHECKSUM=$(sha256sum "$K3S_DOWNLOAD_BINARY" | grep --only-matching -P "^\w+")

# Validate checksum
if [ ! "$K3S_DOWNLOAD_CHECKSUM" = "$(cat "$K3S_DOWNLOAD_CHECKSUM_FILE | grep --only-matching -P "^\w+")" ]; then
    printf "%s\n" "error: checksum invalid, exiting..."
    exit 1
fi

# Get local k3s binary checksum
K3S_LOCAL_CHECKSUM=$(sha256sum "$K3S_BINARY" | grep --only-matching -P "^\w+")

if [ "$K3S_LOCAL_CHECKSUM" = "$K3S_DOWNLOAD_CHECKSUM" ]; then
    printf "%s\n" "k3s is already up to date, exiting..."
    exit 0
fi

# Move the downloaded binary to the local path
mv "$K3S_DOWNLOAD_BINARY" "$K3S_LOCAL_BINARY"

# cleanup
rm "$K3S_DOWNLOAD_CHECKSUM_FILE"