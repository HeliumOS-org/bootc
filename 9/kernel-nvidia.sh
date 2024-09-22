#!/usr/bin/env sh


set -e


dnf install -y \
    kernel-devel \
    kernel-headers


dnf module install -y \
    nvidia-driver:latest-dkms

