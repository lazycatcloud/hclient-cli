#!/bin/bash

if [[ "$1" = "" ]]; then
    tag=20250514
    echo "will use the default tag ${tag} to build"
else
    tag=$1
fi

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    -t hclient-cli:${tag} \
    -t hclient-cli:latest \
    --build-arg tag=${tag} \
    .
