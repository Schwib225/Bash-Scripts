#!/bin/bash

# Disk space checker

disk_space=(`df -h | awk '{print $5}' | sed 's/%//' `)
hostName=$(hostname)

for i in ${disk_space[@]:1};
    do
        if [ $i -gt 25 ]; then
            echo 'There is a disk above 85% usage, please add space or remove unecessary files on' $hostName
        else
            continue
        fi
    done
