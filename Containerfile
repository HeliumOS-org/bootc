FROM quay.io/centos-bootc/centos-bootc:stream9

COPY ./*.service /usr/lib/systemd/system/

RUN dnf install -y epel-release && crb enable

RUN dnf install -y \
	gdm \
	bluez-cups cups-filters gutenprint-cups cups-pk-helper \
	hplip colord paps samba-client system-config-printer-udev \
	cups-pdf enscript foomatic foomatic-db-ppds pnm2ppa splix \
#	NetworkManager-*-gnome NetworkManager-adsl NetworkManager-ppp NetworkManager-wwan \
#	ModemManager gnome-bluetooth glib-networking nss-mdns \
	xdg-desktop-portal-gnome fprintd-pam \
	gvfs-client gvfs-smb gvfs-mtp gvfs-gphoto2 gvfs-goa gvfs-fuse 

RUN dnf install -y --exclude PackageKit \
	gnome-software gnome-terminal nautilus gnome-photos gnome-calculator \
	gnome-disk-utility gnome-initial-setup gnome-characters gnome-color-manager \
	gnome-font-viewer gnome-screenshot gnome-system-monitor gnome-logs

RUN dnf install -y chromium

RUN sed -i 's,REDHAT_SUPPORT_PRODUCT_VERSION="CentOS Stream",,g' /usr/lib/os-release && \
	sed -i 's,REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux 9",,g' /usr/lib/os-release && \
	sed -i 's,https://issues.redhat.com/,https://bugs.heliumos.org/,g' /usr/lib/os-release && \
	sed -i 's,https://centos.org/,https://heliumos.org/,g' /usr/lib/os-release && \
	sed -i 's,CPE_NAME="cpe:/o:centos:centos:9",,g' /usr/lib/os-release && \
	sed -i 's,ID_LIKE="rhel fedora",ID_LIKE="rhel fedora centos",g' /usr/lib/os-release && \
	sed -i 's,ID="centos",ID="heliumos",g' /usr/lib/os-release && \
	sed -i 's,CentOS Stream,HeliumOS,g' /usr/lib/os-release

