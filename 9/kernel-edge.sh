#!/usr/bin/env sh


set -e


dnf remove -y \
    kernel \
    kernel-core \
    kernel-modules-core \
    kernel-modules


rm -rdf /usr/lib/modules/*


dnf install -y \
    kernel-ml \
    kernel-ml-core \
    kernel-ml-modules \
    kernel-ml-modules-extra


kver=$(cd /usr/lib/modules && echo * | awk '{print $1}')


dracut -vf /usr/lib/modules/$kver/initramfs.img $kver
