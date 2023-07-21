#!/bin/bash

obtainadminpassword(){
    if [ $passwordsource == "legacy" ]; then
        read -p "Enter Admin Password (You'll only need to do this once): " adminpassword
	    echo "$adminpassword" > password.conf
    fi
}

checknetworkconnection(){
    if [[ $(ping -q -c1 $connectioncheckurl &>/dev/null && echo online || echo offline) == "offline" ]]; then
        echo "No Network Connection"
        exit 1
    fi
}