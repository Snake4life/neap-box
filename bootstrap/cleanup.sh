#!/bin/bash

# Removing leftover leases and persistent rules
echo "Cleaning up dhcp leases and rules"
rm /var/lib/dhcp/*

# Make sure Udev doesn't block our network
echo "Cleaning up udev rules"
rm -rf /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

echo "Purge old kernels"
apt-get -y -q remove $(dpkg -l|egrep '^ii  linux-(im|he)'|awk '{print $2}'|grep -v `uname -r`)
update-grub

echo "Update packages to the latest version"
export DEBIAN_FRONTEND=noninteractive
apt-get -y -q update
apt-get -y -q -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
apt-get -y -q dist-upgrade

echo "Clean packages"
apt-get -y -q autoremove
apt-get -y -q clean

echo "Remove all temporary files"
rm -rf /tmp/*
rm -rf /usr/src/*
rm -rf /var/tmp/*
rm -rf /var/log/*.log
rm -rf /var/log/**/*.log

# To remove history, execute the following logged in through SSH:
# cat /dev/null > ~/.bash_history && history -c && exit
