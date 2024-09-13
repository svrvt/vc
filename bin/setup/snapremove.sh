#!/bin/sh
list=$(snap list | grep -v Name | awk '{print $1}' | tr '\n' ' ' | grep -v % | grep -Ev "bare|core20|snapd")
sudo snap remove $list

sudo snap remove bare core20 snapd
# df | grep snapd
# sudo umount /snap/snapd/14978
# or
# sudo umount /var/snap

sudo systemctl stop snapd
sudo systemctl disable snapd
sudo systemctl mask snapd

sudo apt purge snapd -y
sudo apt-mark hold snapd

cat <<EOF >/etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF


# sudo apt install --install-suggests gnome-software
