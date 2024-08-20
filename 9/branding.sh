#!/usr/bin/env sh


set -e


sed -i 's,wiki.almalinux.org,heliumos.org/docs,g' /usr/lib/os-release && \
    sed -i 's,LOGO="fedora-logo-icon",LOGO="heliumos-logo-icon",g' /usr/lib/os-release && \
    sed -i 's,ID="almalinux",ID="heliumos",g' /usr/lib/os-release && \
    sed -i 's,ALMALINUX_MANTISBT_PROJECT="AlmaLinux-9",,g' /usr/lib/os-release && \
    sed -i 's,ALMALINUX_MANTISBT_PROJECT_VERSION="9.4",,g' /usr/lib/os-release && \
    sed -i 's,Seafoam Ocelot,Fire Cypress,g' /usr/lib/os-release && \
    sed -i 's,AlmaLinux,HeliumOS,g' /usr/lib/os-release && \
    sed -i 's,almalinux,heliumos,g' /usr/lib/os-release && \
    sed -i 's,ID_LIKE="rhel centos fedora",ID_LIKE="rhel centos fedora almalinux",g' /usr/lib/os-release


git clone https://codeberg.org/HeliumOS/logo.git && \
	cd logo && \
	git checkout 0ce8b5cd8f && \
	mv export/logo/logo-color.svg /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon.svg && \
	mv export/logo/logo.svg /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon-white.svg && \
	mv export/logo/logo-color-256x256.png /usr/share/icons/hicolor/256x256/apps/heliumos-logo-icon.png && \
	mv export/logo/logo-color-64x64.png /usr/share/icons/hicolor/64x64/apps/heliumos-logo-icon.png && \
	ln -sf /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon.svg /usr/share/icons/hicolor/scalable/apps/start-here.svg && \
	ln -sf /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon.svg /usr/share/icons/hicolor/scalable/apps/xfce4_xicon1.svg && \
	ln -sf /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon.svg /usr/share/almalinux-logos/fedora_logo.svg && \
	ln -sf /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon-white.svg /usr/share/almalinux-logos/fedora_logo_darkbackground.svg && \
	ln -sf /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon.svg /usr/share/pixmaps/fedora-logo-sprite.svg && \
	ln -sf /usr/share/icons/hicolor/256x256/apps/heliumos-logo-icon.png /usr/share/pixmaps/fedora-logo-sprite.png && \
	ln -sf /usr/share/icons/hicolor/256x256/apps/heliumos-logo-icon.png /usr/share/pixmaps/fedora-logo.png && \
	ln -sf /usr/share/icons/hicolor/64x64/apps/heliumos-logo-icon.png /usr/share/pixmaps/fedora-gdm-logo.png && \
	ln -sf /usr/share/icons/hicolor/64x64/apps/heliumos-logo-icon.png /usr/share/pixmaps/fedora-logo-small.png && \
	cd .. && rm -rdf logo


curl -o wallpapers.tar.gz https://codeberg.org/HeliumOS/wallpapers/archive/eccec97df37d4d5aee4f23e1e57b46c0e4e6c484.tar.gz && \
    tar -xzf wallpapers.tar.gz && \
    rm wallpapers.tar.gz && \
    cp /workdir/wallpapers/desktop-backgrounds-default.xml /usr/share/gnome-background-properties/desktop-backgrounds-default.xml && \
    mkdir -p /usr/share/backgrounds/heliumos && \
    cp /workdir/wallpapers/*.jpg /usr/share/backgrounds/heliumos
