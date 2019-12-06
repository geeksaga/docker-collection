#!/usr/bin/env bash

function main() {
    docker run \
        --rm \
        -it \
        geeksaga/alpine-neovim:latest zsh
}

main
