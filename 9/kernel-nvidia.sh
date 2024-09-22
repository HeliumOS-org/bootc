#!/usr/bin/env sh


set -e


dnf remove -y \
    kernel-core


dnf install -y \
    kernel-core \
    kernel-devel


dnf module install -y \
    nvidia-driver:latest-dkms


kver=$(cd /usr/lib/modules && echo * | awk '{print $1}')


dracut -vf /usr/lib/modules/$kver/initramfs.img $kver
