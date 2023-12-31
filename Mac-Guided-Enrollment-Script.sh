#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

source values.conf

checkadminpermission(){
	if [ "$(echo $adminpassword | sudo -S -k whoami)" != "root" ]; then
		echo "admin"
	fi
}

checklistrender () {
	if [ $checklistge == "true" ]; then
		# Loop through checklist items and display them with checkboxes
    	clear
    	for ((i=0; i<${#checklist[@]}; i++)); do
    	    if [[ ${checklist_status[$i]} -eq 1 ]]; then
    	        checkbox="[x]"
    	    else
    	        checkbox="[ ]"
    	    fi
    	    echo "$checkbox ${checklist[$i]}"
    	done
	fi
}

usercheck () {
	if [ $usernamecheck == "true" ]; then
		if [ $(whoami) != "$requireduser" ]; then
			echo "Login as $requireduser to run this script"
			exit 1
		fi
	fi
}

userlevelcheck(){
	if [[ "$userlevel" == "NUS" ]]; then
		echo "Promoting User to Admin"
		echo "$adminpassword" | sudo -S -k dscl . -merge /Groups/admin GroupMembership $usernamebyid
	fi
	if [[ "$userlevel" == "NMS" ]]; then
		echo "Demoting User to Standard"
		echo "$adminpassword" | sudo -S -k dseditgroup -o edit -d $usernamebyid -t user admin
	fi
	if [[ "$userlevel" == "NLS" ]]; then
		echo "Demoting User to Standard"
		echo "$adminpassword" | sudo -S -k dseditgroup -o edit -d $usernamebyid -t user admin
	fi
	if [[ "$userlevel" == "NFS" ]]; then
		echo "Promoting User to Admin"
		echo "$adminpassword" | sudo -S -k dscl . -merge /Groups/admin GroupMembership $usernamebyid
	fi
	if [[ "$userlevel" == "iLa" ]]; then
		echo "Demoting User to Standard"
		echo "$adminpassword" | sudo -S -k dseditgroup -o edit -d $usernamebyid -t user admin
	fi
}

# Define checklist items
checklist=("Installer Update Check" "Username Check" "Obtain Admin Permissions" "Network Name"  "Bonjour Name" "Device Name" "Script Wrap-Up")
# Sets the checked items
checklist_status=(0 0 0 0 0 0 0)
# Defines the user needed for the script to execute

clear
checklist_status=(1 0 0 0 0 0 0)
checklistrender

# Checks username
usercheck
clear
checklist_status=(1 1 0 0 0 0 0)
checklistrender

# Obtains admin permission from user
if [ $autopassword == "true" ]; then
	echo "$adminpassword" | sudo -S -k echo ""
else
	sudo echo ""
fi
clear
checklist_status=(1 1 1 0 0 0 0)
checklistrender

# Set HostName, ComputerName, and LocalHostName to the full name
if [ $autopassword == "true" ]; then
	echo "$adminpassword" | sudo -S -k scutil --set HostName "$full_name"
else
	sudo scutil --set HostName "$full_name"
fi
clear
checklist_status=(1 1 1 1 0 0 0)
checklistrender

if [ $autopassword == "true" ]; then
	echo "$adminpassword" | sudo -S -k scutil --set LocalHostName "$full_name"
else
	sudo scutil --set LocalHostName "$full_name"
fi
clear
checklist_status=(1 1 1 1 1 0 0)
checklistrender

if [ $autopassword == "true" ]; then
	echo "$adminpassword" | sudo -S -k scutil --set ComputerName "$full_name"
else
	sudo scutil --set ComputerName "$full_name"
fi
clear
checklist_status=(1 1 1 1 1 1 0)
checklistrender

# Renew user enrollment. Taken from user_enrollment.sh
if [ $autopassword == "true" ]; then
	echo "$adminpassword" | sudo -S -k profiles renew -type enrollment
else
	sudo profiles renew -type enrollment
fi
clear
checklist_status=(1 1 1 1 1 1 1)
checklistrender

userlevelcheck