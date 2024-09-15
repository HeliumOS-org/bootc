#!/usr/bin/env sh


set -e


dnf install -y \
    distrobox \
    git


dnf install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin
