#!/bin/bash

# Script to download syslog and replace default files with customized files for monitoring
# Last Modified 6/11/19 by Michael Schweigert

currentUser=$(whoami)                                                   # Check current user, must be root for this script
package=syslog-ng                                                       # Enter package name here
repository=x.x.x.x                                                      # Enter a servername or file location here 
syslogConfigLocation=/etc/syslog-ng/                                    # Enter the temp location or repo file location
syslogConfigFile=syslog-ng.conf                                         # Enter the filename we are moving over
osName=$(grep -m 1 'ID=' /etc/os-release | cut -d= -f2)                 # need to remove the quotes and limit to only the first line or find another file to pull from


function create_move_remove_files {
# Pull file from repo (my centos box) and MV file and replace default  
    mkdir /tmp/syslog_client_install/
# Copy file over - make error checking if unable to do this step
    # Find better way to do this, plain text is terrible
    sshpass -p '4g8L!afv' scp $currentUser@$repository:$syslogConfigLocation/$syslogConfigFile /tmp/syslog_client_install/$syslogConfigFile
# Create a backup copy of default config in the event of issues
    cp /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf_backup
# Replace default config
    mv -f /tmp/syslog_client_install/$syslogConfigFile /etc/syslog-ng/syslog-ng.conf 
# Delete created dir as if it never happened
    rm -rf /tmp/syslog_client_install
}

if [ $currentUser=root ];
then
    # Determine OS and store as variable and install syslog-ng
    if [ $osName=ubuntu OR $osName="ubuntu" ];
    then
        apt install -y $package
        # Wait here to proceed
        create_move_remove_files
    elif [ $osName=centos OR $osName="centos" ];
    then 
        yum install -y $package
        # Wait here to proceed 
        create_move_remove_files
    else
        echo "Unable to determine OS, if not Ubuntu Or Centos please contact the MUL team"
    fi

    # Restart syslog-ng to apply changes
    systemctl restart syslog-ng
    # add error checking because this isn't always going to work ^ 
    systemctl status syslog-ng

else
    echo "Error: You must run this script as root"
fi
