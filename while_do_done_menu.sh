#!/bin/bash
while true
do 
	/usr/bin/clear
	echo "			Menu	"
	echo "	----------------------------------------------  "
	echo "	[1] Display Date and Time Information".
	echo "	[2] Display Basic System Information".
	echo "	[3] Display Local Information".
	echo "	[4] Display Mounted File Systems".
	echo "	[5] Exit".
	echo "	----------------------------------------------  "
	echo 
	echo -e "Enter your choice [1-5]: \c"
	read VAR
	case $VAR in
		1)echo "Current System Date and Time is `/usr/bin/timedatectl`"
		echo 
		echo "Press Enter to go back to the Menu......"
		read
		;;
		2) /usr/bin/hostnamectl
		echo
		echo "Press Enter to go bak to the Menu......."
		read
		;;
		3) /usr/bin/localectl
		echo
		echo "Press Enter to go bak to the Menu......."
		read
		;;
		4) /usr/bin/df -h
		echo "Press Enter to go bak to the Menu......."
		read
		;;
		5)echo "Exiting ...... Bye Bye"
		exit 0
		;;
		*)echo "You have selected an invalid option".
		echo "Please choose a valid choice"
		echo "Press Enter to go back to the Menu....."
		read
		;;
	esac
done
