#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" || echo "changing directory failed" && exit

source values.conf

tpink="\x1b[38;5;199m"
tblue="\x1b[38;5;33m"

printf '%b' "SUPPORT ${tblue}T${tpink}R\033[0mA${tpink}N${tblue}S\033[0m RIGHTS\n"

migratepasswordfile(){
    if [ -f password.txt ]; then
        cat password.txt > password.conf
        rm password.txt
    fi
}

checkformissingconfig(){
    if [ ! -f values.conf ]; then
        echo "Invalid or Missing Config File. Obtain a Valid One from Github."
        exit 1
    fi
}

downloadstructureimage(){
    curl -s https://raw.githubusercontent.com/actualaardvark/bashsetupscriptrepo/$gitupdatebranch/structure.conf > structure.conf
    filestodownload=()
    ishidden="false"
    while IFS= read -r line; do
        filestodownload+=("$line")
    done < "structure.conf"
    for ((i = 0; i < ${#filestodownload[@]}; i++)); do
        if [ "${filestodownload[$i]}" = '#hide' ]; then
            ishidden="true"
        else
            downloadedfile=${filestodownload[$i]}
            if [ ! -f "$downloadedfile" ]; then
                if [[ $downloadedfile == *"/"* ]]; then
                    mkdir -p "${downloadedfile%/*}" && touch "$downloadedfile"
                else
                    touch "$downloadedfile"
                fi
            fi
            curl -s  https://raw.githubusercontent.com/actualaardvark/bashsetupscriptrepo/$gitupdatebranch/${filestodownload[$i]} > ${filestodownload[$i]}
            if [[ $ishidden == "true" ]]; then
                chflags hidden "${filestodownload[$i]}"
                ishidden=false
            fi
            chmod +x "${filestodownload[$i]}"
        fi
    done
}

checknetworkconnection(){
    if [[ $(ping -q -c1 $connectioncheckurl &>/dev/null && echo online || echo offline) == "offline" ]]; then
        echo "No Network Connection"
        exit 1
    fi
}

checkformissingconfig

if [ $connectioncheckenabled == "true" ]; then
    checknetworkconnection
fi

downloadstructureimage

migratepasswordfile

rm -rf "Additional Scripts"
