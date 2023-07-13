# Gets the users full name. Taken from Naming_Convention.sh
full_name=$(dscl . -read /Users/$(id -un 502) RealName | awk -F': ' '{print $2}')
# The first 3 letters of the user account's full name
userlevel = ${full_name:0:3}

if [ "$userlevel" = "NLS" ]; then
	echo "L"
fi
if [ "$userlevel" = "NMS" ]; then
	echo "M"
fi