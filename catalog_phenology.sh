#!/bin/sh

# Script to catalog assets for EOMF Phenocam
source .config.sh

TMPDIR=$(mktemp -d)
curl -o /dev/null -s -c ${TMPDIR}/session.jar ${AUTHLOC}
CSRFTOKEN=$(cat ${TMPDIR}/session.jar |grep csrftoken | cut -f7)
curl -o /dev/null -s -b ${TMPDIR}/session.jar -c ${TMPDIR}/auth.jar \
    -d "username=${CCDC_USERNAME}&password=${CCDC_PASSWORD}&csrfmiddlewaretoken=${CSRFTOKEN}" ${AUTHLOC} 

AUTH=${TMPDIR}/auth.jar

catalog_post() {
    curl -H "Content-type: application/json" -b ${AUTH} -d @- ${CATALOGWS}
}


catalog_post;



