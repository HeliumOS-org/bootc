#!/usr/bin/env sh


set -e


# https://codeberg.org/HeliumOS/bugs/issues/2
dnf install -y \
    https://repo.almalinux.org/almalinux/9/AppStream/x86_64/os/Packages/ocl-icd-2.2.13-4.el9.x86_64.rpm


dnf install -y \
    distrobox \
    chromium \
    git

    
dnf install -y \
    https://kojipkgs.fedoraproject.org//packages/bootc-gtk/0.3/1.el9/noarch/bootc-gtk-0.3-1.el9.noarch.rpm

