#!/bin/bash

# Install IP address information or these scripts won't work - host must have working IP with routing 
echo 'DNS1=x.x.x.x' >> /etc/sysconfig/network-scripts/ifcfg-ens192
echo 'DNS2=x.x.x.x' >> /etc/sysconfig/network-scripts/ifcfg-ens192
/etc/sysconfig/network_scripts/ifdown ens192
/etc/sysconfig/network_scripts/ifup ens192


# Install proxy server configs
echo "http_proxy=http://proxy:3128" >> /etc/environment
echo "https_proxy=https://proxy:3128" >> /etc/environment
systemctl restart network

# First, install updates and necessary generic packages
yum -y update


# Install ntp, net-tools, salt minion, ncdu, syslog-ng if necessary

yum install -y ntp net-tools ncdu epel-release

# docker, kubernetes, rancher stuff here separately
# yum install -y docker, kubelet, rke



# Install AD integration
yum install sssd realmd oddjob oddjob-mkhomedir adcli samba-common samba-common-tools krb5-workstation openldap-clients policycoreutils-python -y

# Ensure the dns server is also the AD server address
cat /etc/resolv.conf

# If it is, attempt to join the realm
realm join --user=administrator example.com

# Confirm
realm list

## If i ever need it, how to leave the realm ##
# realm leave example.com

