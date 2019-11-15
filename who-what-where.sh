#!/bin/bash

# Current User:
whoami

# Current Connections:
w

# Current OS w/ new OSes -- add grep for line that is needed 
cat /etc/os-release

# Older OSes - includes linux version
cat /proc/version

# Current IP address, add code to turn into an array

ip a s

ifconfig

# Current host name
cat /etc/hostname
# Or 
hostname 
uname -n

# get dns info, add code to turn into an array
cat /etc/resolv.conf
cat /etc/hosts

# Hardware
## Processor
uname -p
lscpu

## Platform
uname -i 

## All Hardware
lshw 

## List block devices (drives)
lsblk

## list usb devices
lsusb

You can also view information about the following devices of your system:

## PCI devices
lspci

## SCSI devices
lsscsi

SATA devices