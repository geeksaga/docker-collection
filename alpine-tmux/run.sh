#!/usr/bin/env bash

function main() {
    docker run \
        --rm \
        -it \
        geeksaga/alpine-tmux:latest zsh
}

main
