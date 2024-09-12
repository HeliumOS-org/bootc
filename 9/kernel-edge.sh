#!/usr/bin/env sh


set -e


kver=6.8.5-301.fc40.x86_64
fver=40


curl -O https://dl.fedoraproject.org/pub/fedora/linux/releases/$fver/Everything/x86_64/os/Packages/k/kernel-$kver.rpm
curl -O https://dl.fedoraproject.org/pub/fedora/linux/releases/$fver/Everything/x86_64/os/Packages/k/kernel-core-$kver.rpm
curl -O https://dl.fedoraproject.org/pub/fedora/linux/releases/$fver/Everything/x86_64/os/Packages/k/kernel-modules-core-$kver.rpm
curl -O https://dl.fedoraproject.org/pub/fedora/linux/releases/$fver/Everything/x86_64/os/Packages/k/kernel-modules-$kver.rpm


dnf remove -y \
    kernel \
    kernel-core \
    kernel-modules-core \
    kernel-modules


dnf install -y \
    ./kernel-*.rpm


dnf install -y \
    kmod-kvdo \
    vdo


rm -rdf /usr/lib/modules/5.*


dracut -vf /usr/lib/modules/$kver/initramfs.img $kver
