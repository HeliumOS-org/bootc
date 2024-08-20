#!/usr/bin/env bash


set -e


dnf install -y --nobest \
	@Workstation


dnf install -y \
    https://mirror.stream.centos.org/9-stream/AppStream/x86_64/os/Packages/gnome-software-45.3-1.el9.x86_64.rpm


dnf install -y \
	gnome-tweaks \
	gnome-extensions-app \
	gnome-shell-extension-appindicator \
	NetworkManager-openvpn-gnome


dnf install -y \
    https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/35/Everything/x86_64/os/Packages/g/gnome-shell-extension-gsconnect-47-2.fc35.x86_64.rpm


dnf remove -y \
    evolution \
    setroubleshoot \
    cockpit \


glib-compile-schemas /usr/share/glib-2.0/schemas/


systemctl enable \
    gdm.service


rm -rdf /var/run
