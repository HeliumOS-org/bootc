ostreecontainer --url <URL>

autopart --nohome
zerombr
clearpart --none --initlabel

network --bootproto=dhcp --device=link --activate

rootpw --lock
timezone America/Chicago

%addon com_redhat_kdump --disable
%end

%post

rm -f /var/lib/systemd/random-seed

systemctl disable kdump.service

%end