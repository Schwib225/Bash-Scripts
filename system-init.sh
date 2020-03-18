#!/bin/bash
##TODO = build static variables to be defined ata beginning of script so everything will run without other manual intervention
PROXY_SERVER=mul-proxy
DNS_SERVERS=(10.57.176.28 10.57.176.29)
INTERFACE_NAME=ens192
SALT_MASTER=salt
NTP_SERVERS=(10.57.24.25 10.57.24.26)
REG_PACKAGES=(epel-release ntp net-tools ncdu salt-minion)        # package managers first
AD_PACKAGES=(sssd realmd oddjob oddjob-mkhomedir adcli samba-common samba-common-tools krb5-workstation openldap-clients policycoreutils-python) # AD packages
AD_SERVER=(10.57.176.28 10.57.176.29)
DOMAIN=mini.uplink

# Install IP address information or these scripts won't work - host must have working IP with routing 
#MODIFY IP ADDRESS/NETMASK/GATEWAY
#MODIFY INTERFACE TO BE ONBOOT=yes and BOOTPROTO=static 
sed -i 's/ONBOOT=no/ONBOOT=yes/g' /etc/sysconfig/network-scripts/ifcfg-${INTERFACE_NAME}
sed -i 's/BOOTPROTO=dhcp/BOOTPROTO=static/g'/etc/sysconfig/network-scripts/ifcfg-${INTERFACE_NAME}
#echo 'IPADDR=x.x.x.x' >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE_NAME}
#echo 'NETMASK=x.x.x.x' >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE_NAME}
#echo 'GATEWAY=x.x.x.x' >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE_NAME}
echo 'DNS1=x.x.x.x' >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE_NAME}
echo 'DNS2=x.x.x.x' >> /etc/sysconfig/network-scripts/ifcfg-${INTERFACE_NAME}
/etc/sysconfig/network_scripts/ifdown ${INTERFACE_NAME}
/etc/sysconfig/network_scripts/ifup ${INTERFACE_NAME}
systemctl restart network


# Install proxy server configs
echo "http_proxy=http://${PROXY_SERVER}:3128" >> /etc/environment
echo "https_proxy=https://${PROXY_SERVER}:3128" >> /etc/environment
systemctl restart network

# First, install updates and necessary generic packages
yum -y update

# Install reg packages
for i in ${REG_PACKAGES[@]}; do yum install -y $i; done

# configure ntp 
vi /etc/ntpd.conf
    #TODO comment out current server configs and replace with my own
server x.x.x.x
systemctl restart ntpd

# configure salt-minion
vi /etc/salt/minion
# uncomment master name - $SALT_MASTER
systemctl restart salt-minion

### TODO: Automate AD integration
### Install AD integration packages
for i in ${AD_PACKAGES[@]}; do yum install -y $i; done


# Ensure the dns server is also the AD server address
cat /etc/resolv.conf
    # grep for DNS_SERVER, basically compare if DNS_SERVER and AD_SERVER match

# If it is, attempt to join the realm
realm join --user=administrator ${DOMAIN}         # will prompt you for a password currently

# need to ensure that realm is started - needed to reboot in order to allow joining - next attempt be sure to try and restart realmd - check for other services that might not be started (from the list of software installed above)

# Modify this value - make sed edit - ensure the spaces are there
sed 's/use_fully_qualified_names = True/use_fully_qualified_names = False/g' /etc/sssd/sssd.conf

systemctl restart sssd      # will need to do this to apply settings

# Confirm
realm list

## If i ever need it, how to leave the realm ##
# realm leave ${DOMAIN}

## TODO: Add script for docker, kubernetes, rke setup

# yum install -y docker, kubelet, rke
