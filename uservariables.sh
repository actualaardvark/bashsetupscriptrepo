#!/bin/bash

usernamebyid=$(id -un $userid)

# Gets the users full name. Taken from Naming_Convention.sh
full_name=$(dscl . -read /Users/$usernamebyid RealName | awk -F': ' '{print $2}')

# The first 3 letters of the user account's full name
userlevel=${full_name:0:$prefixlength}

if [ $passwordsource == "legacy" ]; then
    adminpassword=$(cat password.conf)
fi
if [ $passwordsource == "config" ]; then
    adminpassword=$adminpasswordconf
fi