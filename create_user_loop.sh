#!/bin/bash
for USER in user{10..14}
	do
		echo "Creating account for user $USER".
		/usr/sbin/useradd -m -d /home/$USER -s /bin/bash $USER
		if [ $? = 0 ]
			then
				echo $USER | /usr/bin/passwd --stdin $USER
				echo "$USER Created Successfully."
			else
				echo "Failed to create account $USER".
				exit
		fi
	done
