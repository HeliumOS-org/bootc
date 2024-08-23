#!/usr/bin/env sh


set -e


kver=$(cd /usr/lib/modules && echo * | awk '{print $1}')


dracut -vf /usr/lib/modules/$kver/initramfs.img $kver
