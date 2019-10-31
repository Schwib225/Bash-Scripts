#!/bin/bash

# Ping sweep for logzilla - will read a file with host names. To remove hosts from this monitoring we should be able to add a character 
# or something like # to stop that host from being ping'd

# Requires the text file to work - create it manually for now

# Generic enhancements remaining:
# checking those values for a # in front to decide whether to proceed  


host_list=(`cat /tmp/host_list.txt`)

for i in ${host_list[@]};
    do
        pingTest=$(ping -c 1 $i | grep packets | awk '{print $4}')
        if [[ $pingTest !=  1 ]]; then
                echo "$i failed"
                sleep 1
                pingTest2=$(ping -c 1 $i | grep packets | awk '{print $4}')
                if [[ $pingTest2 != 1 ]]; then
                    echo "Ping test to host $i has failed twice, please confirm the host is up and running" #>> /var/log/messages -- verify the path on logzilla where it is getting its own logs from
                else
                    continue
                fi
        else
            continue
        fi;
    done
