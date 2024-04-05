#!/bin/bash
set -e
COMP_NAME=$(basename "$PWD")
# Not Sure.
if [[ ${COMP_NAME} == "" ]]; then
    COMP_NAME=miniOneLifeCompile
fi

PLATFORM=$1
FOLDERS=$2
TARGET=$3
LINK=$4
for f in $FOLDERS; do
	if [[ $PLATFORM == 1 ]] && [ ! -h $f ]; then ln -s $LINK/$f $TARGET/$f; fi
    if [[ $PLATFORM == 5 ]]; then
        if [ -h $f ]; then rm ./$f; fi
        ../"${COMP_NAME}"/util/mklink.sh /J $TARGET/$f $LINK/$f
    fi
done;