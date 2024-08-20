#!/usr/bin/env sh


set -e


dnf install -y \
    epel-release


dnf config-manager --set-enabled \
    crb


dnf config-manager --save \
    --setopt=exclude=PackageKit,PackageKit-command-not-found,rootfiles,firefox,totem,gnome-tour


mkdir -p /etc/flatpak/remotes.d && \
    curl -o /etc/flatpak/remotes.d/flathub.flatpakrepo  https://dl.flathub.org/repo/flathub.flatpakrepo
