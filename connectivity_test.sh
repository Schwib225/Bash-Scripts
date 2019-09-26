#!/bin/bash

# Ping sweep for logzilla - will read a file with host names. To remove hosts from this monitoring we should be able to add a character 
# or something like # to stop that host from being ping'd


# Challenges remaining: 1. pulling values from the file   2. checking those values for a # in front to decide whether to proceed  3. actually ping those devices and if it fails then write to file
host_list=/root/Documents/scripts/host_list.txt

for i in $host_list;
    if [$i ] # starts with '#' - will need to use awk and sed here - this will allow us to 'remove' hosts from the test gracefully
    then 
        continue # skip the ping
    else [
    do
        pingTest=$(ping $i -c 2 | grep packets | awk '{print $4}')   ## currently the script doesn't understand the $i variable here - works w/ manual input of an ip
        if $pingTest -ne 2 # ping fails wait 10 seconds and try again. 
            then
                sleep 10
                pingTest2=$(ping $i -c 2 | grep packets | awk '{print $4}')  ## currently the script doesn't understand the $i variable here - works w/ manual input of an ip
                if $pingTest2 -ne 2
                then
                    echo 'Ping test to host $i has failed twice, please confirm the host is up and running' #>> /var/log/messages
                else
                    continue
                fi
        else
            continue
        fi
    done
    ] 




