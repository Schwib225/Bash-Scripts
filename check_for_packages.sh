#!/bin/bash

# TODO: Prompt user for package - allow this to be an array - note will need to be separated on each line
echo 'Please input the package names you are looking for: '
packages=#(read command)

# TODO: cycle through the array to check if the package is installed. Should be able to determine if it is using yum or apt 

for i in $packages:
  #yum/apt package list | grep $i
