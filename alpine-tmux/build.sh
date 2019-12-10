#!/usr/bin/env bash

# build image
docker build --tag geeksaga/alpine-tmux.

# remove build image
docker rmi $(docker images --filter "dangling=true" -aq)

# push image to dockerr hub
#docker push geeksaga/apline-tmux:latest
