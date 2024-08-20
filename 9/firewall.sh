#!/usr/bin/env sh


set -e


dnf install -y \
    firewall-config


wget -O /usr/lib/firewalld/zones/HeliumOS.xml \
	https://src.fedoraproject.org/rpms/firewalld/raw/90e646ef020a9c2e680a3f7c296e8ce1d4a5abc5/f/FedoraWorkstation.xml \
	&& sed -i 's,DefaultZone=public,DefaultZone=HeliumOS,g' /etc/firewalld/firewalld.conf
