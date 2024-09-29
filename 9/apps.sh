#!/usr/bin/env sh


set -e


dnf install -y \
    distrobox \
    git


dnf install -y \
    https://kojipkgs.fedoraproject.org//packages/bootc-gtk/0.3/1.el9/noarch/bootc-gtk-0.3-1.el9.noarch.rpm

