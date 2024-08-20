#!/usr/bin/env sh


set -e


dnf install -y \
    python3.11 \
    flatpak-builder


mkdir /var/roothome


curl -O https://codeberg.org/HeliumOS/flatpak-readonlyroot/raw/tag/v0.1/flatpak-readonlyroot.py


python3.11 flatpak-readonlyroot.py flatpak.toml


curl -o bootc-gtk.flatpak https://codeberg.org/HeliumOS/bootc-gtk/releases/download/0.2/org.heliumos.bootc_gtk.flatpak


flatpak install \
    -y \
    --installation=installation \
    bootc-gtk.flatpak
