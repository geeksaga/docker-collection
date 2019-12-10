#!/usr/bin/env bash

function main() {
    docker run \
#        --rm \
        -v ~/.ssh/id_rsa.pub:/etc/ssh_keys:ro \
        -v /etc/localtime:/etc/localtime:ro \
        -d -p 80:80 -p 8080:8080 -p 62222:62222 -p 60001:60001/udp \
        --name dev \
        geeksaga/alpine-dev:latest
}

main
