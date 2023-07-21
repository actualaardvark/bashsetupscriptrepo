#!/bin/bash

installappcheckscript(){
    if [ ! -d "Additional Scripts" ]; then
        mkdir "Additional Scripts"
    fi
    curl -s https://raw.githubusercontent.com/actualaardvark/bashsetupscriptrepo/$gitupdatebranch/Additional%20Scripts/App%20Install%20Inspector > "Additional Scripts"/"App Install Inspector"
    chmod +x "Additional Scripts"/"App Install Inspector"
}

updatecheck(){
	if [ $updatecheck == "true" ]; then
		# Replaces the old version with the new if the old copy is out of date
		if [ "$(curl -s https://raw.githubusercontent.com/actualaardvark/bashsetupscriptrepo/$gitupdatebranch/updateandrun)" != "$(cat updateandrun)" ]; then
			echo "Updater out of date"
			curl -s https://raw.githubusercontent.com/actualaardvark/bashsetupscriptrepo/$gitupdatebranch/updateandrun > updateandrun
			chmod +x updateandrun
			sh updateandrun
			exit 1
		else
			echo "Updater is on the latest version"
		fi
	fi
}

checkformissingconfig(){
    if [ ! -f values.conf ]; then
        echo "Invalid or Missing Config File. Obtain a Valid One from Github."
        exit 1
    fi
}

checkformissingpassword(){
    if [ ! -f  password.conf ]; then
        obtainadminpassword
    fi
}

installosreinstallscript(){
    if [ ! -d "Additional Scripts" ]; then
        mkdir "Additional Scripts"
    fi
    curl -s https://raw.githubusercontent.com/actualaardvark/bashsetupscriptrepo/$gitupdatebranch/Additional%20Scripts/Reinstall%20OS > "Additional Scripts"/"Reinstall OS"
    chmod +x "Additional Scripts"/"Reinstall OS"
}

updateconfigfile(){
    if [ $configautoupdate == "true" ]; then
        if [ "$(curl -s $configupdateurl)" != "$(cat values.conf)" ]; then
	        echo "Configuration file out of date"
	        curl -s "$configupdateurl" > values.conf
	        sh updateandrun
	        exit 1
	    else
	        echo "Configuration file is up to date"
	    fi
    fi
}