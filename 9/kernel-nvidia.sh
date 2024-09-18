#!/usr/bin/env sh


set -e


dnf module install -y \
    nvidia-driver:latest-dkms


kver=$(cd /usr/lib/modules && echo * | awk '{print $1}')


dracut -vf /usr/lib/modules/$kver/initramfs.img $kver
