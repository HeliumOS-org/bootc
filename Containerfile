FROM quay.io/centos-bootc/centos-bootc:stream9

COPY ./*.service /usr/lib/systemd/system/

RUN dnf install -y epel-release && crb enable

RUN dnf install -y git unzip vim

RUN dnf install -y \
	gdm \
	bluez-cups cups-filters gutenprint-cups cups-pk-helper \
	hplip colord paps samba-client system-config-printer-udev \
	cups-pdf enscript foomatic foomatic-db-ppds pnm2ppa splix \
	NetworkManager-fortisslvpn-gnome NetworkManager-libreswan-gnome \
	NetworkManager-openconnect-gnome NetworkManager-openvpn-gnome \
	NetworkManager-pptp-gnome NetworkManager-l2tp-gnome \
	xdg-desktop-portal-gnome fprintd-pam \
	gvfs-client gvfs-smb gvfs-mtp gvfs-gphoto2 gvfs-goa gvfs-fuse 

RUN dnf install -y --exclude PackageKit \
	gnome-software gnome-terminal nautilus eog gedit gnome-calculator \
	gnome-disk-utility gnome-initial-setup gnome-characters gnome-color-manager \
	gnome-font-viewer gnome-screenshot gnome-system-monitor gnome-logs \
	file-roller-nautilus gnome-tweaks firewall-config \
	gnome-extensions-app gnome-shell-extension-appindicator 

RUN dnf install -y https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/35/Everything/x86_64/os/Packages/g/gnome-shell-extension-gsconnect-47-2.fc35.x86_64.rpm

RUN dnf remove -y gnome-tour centos-backgrounds

RUN dnf install -y distrobox chromium

RUN sed -i 's,REDHAT_SUPPORT_PRODUCT_VERSION="CentOS Stream",,g' /usr/lib/os-release && \
	sed -i 's,REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux 9",,g' /usr/lib/os-release && \
	sed -i 's,https://issues.redhat.com/,https://bugs.heliumos.org/,g' /usr/lib/os-release && \
	sed -i 's,https://centos.org/,https://heliumos.org/,g' /usr/lib/os-release && \
	sed -i 's,CPE_NAME="cpe:/o:centos:centos:9",,g' /usr/lib/os-release && \
	sed -i 's,ID_LIKE="rhel fedora",ID_LIKE="rhel fedora centos",g' /usr/lib/os-release && \
	sed -i 's,ID="centos",ID="heliumos",g' /usr/lib/os-release && \
	sed -i 's,CentOS Stream,HeliumOS,g' /usr/lib/os-release && \
	sed -i 's,LOGO="fedora-logo-icon",LOGO="heliumos-logo-icon",g' /usr/lib/os-release

RUN git clone https://codeberg.org/HeliumOS/logo.git && \
	cd logo && \
	git checkout 0ce8b5cd8f && \
	mv export/logo/logo-color.svg /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon.svg && \
	mv export/logo/logo.svg /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon-white.svg && \
	mv export/logo/logo-color-256x256.png /usr/share/icons/hicolor/256x256/apps/heliumos-logo-icon.png && \
	mv export/logo/logo-color-64x64.png /usr/share/icons/hicolor/64x64/apps/heliumos-logo-icon.png && \
	ln -sf /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon.svg /usr/share/icons/hicolor/scalable/apps/start-here.svg && \
	ln -sf /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon.svg /usr/share/icons/hicolor/scalable/apps/xfce4_xicon1.svg && \
	ln -sf /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon.svg /usr/share/centos-logos/fedora_logo.svg && \
	ln -sf /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon-white.svg /usr/share/centos-logos/fedora_logo_darkbackground.svg && \
	ln -sf /usr/share/icons/hicolor/scalable/apps/heliumos-logo-icon.svg /usr/share/pixmaps/fedora-logo-sprite.svg && \
	ln -sf /usr/share/icons/hicolor/256x256/apps/heliumos-logo-icon.png /usr/share/pixmaps/fedora-logo-sprite.png && \
	ln -sf /usr/share/icons/hicolor/256x256/apps/heliumos-logo-icon.png /usr/share/pixmaps/fedora-logo.png && \
	ln -sf /usr/share/icons/hicolor/64x64/apps/heliumos-logo-icon.png /usr/share/pixmaps/fedora-gdm-logo.png && \
	ln -sf /usr/share/icons/hicolor/64x64/apps/heliumos-logo-icon.png /usr/share/pixmaps/fedora-logo-small.png && \
	cd .. && rm -rdf logo
	
RUN git clone https://codeberg.org/HeliumOS/wallpapers.git && \
	cd wallpapers && \
	git checkout eccec97df3 && \
	mv desktop-backgrounds-default.xml /usr/share/gnome-background-properties/desktop-backgrounds-default.xml && \
	mkdir -p /usr/share/backgrounds/heliumos && \
	cp ./*.jpg /usr/share/backgrounds/heliumos && \
	cd .. && rm -rdf wallpapers

COPY gschema_overrides/* /usr/share/glib-2.0/schemas/

RUN glib-compile-schemas /usr/share/glib-2.0/schemas/

