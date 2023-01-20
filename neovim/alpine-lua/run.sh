#!/usr/bin/env bash

function main() {
    docker run \
        --rm \
        -it \
        geeksaga/alpine-lua:latest zsh
}

main
