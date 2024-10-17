#!/usr/bin/env sh


set -e


dnf install -y \
    epel-release


rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org \
    && dnf install -y https://www.elrepo.org/elrepo-release-9.el9.elrepo.noarch.rpm


dnf config-manager --add-repo \
    https://developer.download.nvidia.com/compute/cuda/repos/rhel9/x86_64/cuda-rhel9.repo


dnf config-manager --set-enabled \
    elrepo-kernel \
    crb


dnf config-manager --save \
    --setopt=exclude=PackageKit,PackageKit-command-not-found,rootfiles,firefox,totem,gnome-tour


mkdir -p /etc/flatpak/remotes.d && \
    curl -o /etc/flatpak/remotes.d/flathub.flatpakrepo  https://dl.flathub.org/repo/flathub.flatpakrepo
