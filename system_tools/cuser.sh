#!/bin/bash
FILE=/root/userlist.txt
cat $FILE | while read USER
do
	echo "Creating account for user $USER".
	/usr/sbin/useradd -m -d /home/$USER -s /bin/bash $USER

if [ $? = 0 ]
	then
		echo $USER | /usr/bin/passwd --stdin $USER
		echo "$USER successfully created."
	else
		echo "Failed to create user account $USER"
		exit 
fi 
done
