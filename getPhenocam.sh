#!/bin/sh

source ./config.sh # Import configuration

fileincat () 
{ 
    # example: fileincat Marena-2012-0903-103001.jpg eomf_phenocam
    FILE=$1;
    CATALOG=$2;
    QSTRING="%7B%22spec%22:%7B%22filename%22:%7B%22%24regex%22:%22${FILE}%22%7D%7D,%22fields%22:[%22filename%22]%7D"
    QUERY=$(curl -s -d query=${QSTRING} ${CATALOGSERVER}/$CATALOG/data/)
    if [ "$QUERY" == "[]" ]; then echo "false"; else echo "true"; fi
}

for site in ${SITES}; do
    rsync --perms --chmod=a+r -avz -e "ssh -i ${SSHKEY}" \
        ${RSYNCSOURCE}/${site}/*.jpg ${RSYNCTARGET}/${site}
    for file in $(find ${RSYNCTARGET}/${site}/* -mtime -${NDAYS}); do 
        if [ "$(fileincat ${file} eomf_phenocam)" == "false" ]; then
            ${SCRIPTPATH}/eomf_metadata.py ${file} | ${SCRIPTPATH}/catalog_phenology.sh
        else
            echo "Already cataloged ${file}"
        fi
    done
done
