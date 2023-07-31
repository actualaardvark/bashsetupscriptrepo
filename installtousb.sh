#!/bin/bash

# A mirror of the install script from README.md

curl "https://raw.githubusercontent.com/actualaardvark/bashsetupscriptrepo/main/updateandrun" \
> /volumes/"$(df -h | grep -v "/System" | grep "/Volumes" | awk -F'/Volumes/' '{print $2}')"/updateandrun \
&& chmod +x /volumes/"$(df -h | grep -v "/System" | grep "/Volumes" | awk -F'/Volumes/' '{print $2}')"/updateandrun \
&& curl "https://raw.githubusercontent.com/actualaardvark/bashsetupscriptrepo/main/update.sh" \
> /volumes/"$(df -h | grep -v "/System" | grep "/Volumes" | awk -F'/Volumes/' '{print $2}')"/update.sh \
&& chmod +x /volumes/"$(df -h | grep -v "/System" | grep "/Volumes" | awk -F'/Volumes/' '{print $2}')"/update.sh \
&& curl "https://raw.githubusercontent.com/actualaardvark/bashsetupscriptrepo/main/values.conf" \
> /volumes/"$(df -h | grep -v "/System" | grep "/Volumes" | awk -F'/Volumes/' '{print $2}')"/values.conf \
&& chmod +x /volumes/"$(df -h | grep -v "/System" | grep "/Volumes" | awk -F'/Volumes/' '{print $2}')"/values.conf