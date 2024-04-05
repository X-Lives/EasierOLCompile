#!/bin/bash
set -e
AUTORUN=$(cat AUTORUN)
PLATFORM=$(cat PLATFORM_OVERRIDE)
COMP_NAME=$(basename "$PWD")
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then PLATFORM=${1-1}; fi
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then
	echo "Usage: 1 for Linux (Default), 5 for XCompiling for Windows"
	exit 1
fi

pushd .
cd "$(dirname "${0}")/.."

##### Configure and Make
COMPILE_ROOT=$(pwd)
if [[ $PLATFORM == 1 ]]; then
	TARGET_PATH="${COMPILE_ROOT}/output/linux/server_${GAME_NAME}"
elif [[ $PLATFORM == 2 ]]; then
	TARGET_PATH="${COMPILE_ROOT}/output/mac/server_${GAME_NAME}"
elif [[ $PLATFORM == 4 ]]; then
	TARGET_PATH="${COMPILE_ROOT}/output/raspberry/server_${GAME_NAME}"
elif [[ $PLATFORM == 5 ]]; then
    TARGET_PATH="${COMPILE_ROOT}/output/windows/server_${GAME_NAME}"
fi

cd ${GAME_NAME}OneLife/server
./configure $PLATFORM

make

cd ../../..


##### Create Game Folder
mkdir -p ${TARGET_PATH}
cd ${TARGET_PATH}

FOLDERS="objects transitions categories tutorialMaps"
TARGET="."
LINK="${COMPILE_ROOT}/DATA/${DATA_NAME}"
${COMPILE_ROOT}/${COMP_NAME}/util/createLinks.sh $PLATFORM "$FOLDERS" $TARGET $LINK


cp -rn ${COMPILE_ROOT}/${GAME_NAME}/OneLife/server/settings .

cp ${COMPILE_ROOT}/${GAME_NAME}/OneLife/server/firstNames.txt .
cp ${COMPILE_ROOT}/${GAME_NAME}/OneLife/server/lastNames.txt .
cp ${COMPILE_ROOT}/${GAME_NAME}/OneLife/server/wordList.txt .

cp ${COMPILE_ROOT}/DATA/${DATA_NAME}/dataVersionNumber.txt .


##### Copy to Game Folder and Run
if [[ $PLATFORM == 5 ]]; then mv ${COMPILE_ROOT}/${GAME_NAME}/OneLife/server/OneLifeServer.exe .; fi
if [[ $PLATFORM == 1 ]]; then mv ${COMPILE_ROOT}/${GAME_NAME}/OneLife/server/OneLifeServer .; fi

popd
if [[ $AUTORUN == 1 ]]; then ./runServer.sh; fi