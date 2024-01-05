#!/bin/bash

MODNAME="${1%/}"

if [ ! -d "$MODNAME" ]; then
    echo "Invalid mod name ${MODNAME}"
    exit
fi

if [ ! -f "${MODNAME}/info.json" ]; then
    echo "Missing info.json from ${MODNAME}/"
    exit
fi

VERSION=$(jq -r .version "${MODNAME}/info.json")

ZIPFILE="build/${MODNAME}_${VERSION}.zip"
ZIGNORE="${MODNAME}/.zipignore"
IGNOREFILE="build/${MODNAME}-ignore"

if [ -f "${ZIGNORE}" ]; then
    if [ -f ${IGNOREFILE} ]; then
        rm "${IGNOREFILE}"
    fi

    echo "${ZIGNORE}" > ${IGNOREFILE}

    cat ${ZIGNORE} | while read entry || [[ -n $entry ]];
    do
        echo "${MODNAME}/$entry" >> ${IGNOREFILE}
    done

    ZIGNORE_OPTS="-x @${IGNOREFILE}"
else
    ZIGNORE_OPTS=""
fi

zip -r "${ZIPFILE}" "${MODNAME}/" $ZIGNORE_OPTS
