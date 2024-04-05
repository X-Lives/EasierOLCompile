#!/bin/bash
set -e
PLATFORM=$(cat PLATFORM_OVERRIDE)
DATA_NAME=$(cat DATA_NAME)
GAME_NAME=$(cat GAME_NAME)
COMP_NAME=$(basename "$PWD")
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then PLATFORM=${1-5}; fi
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then
	echo "Usage: 1 for Linux, 5 for XCompiling for Windows (Default)"
	exit 1
fi
cd "$(dirname "${0}")/.."

##### Configure and Make
COMPILE_ROOT=$(pwd)
if [[ $PLATFORM == 1 ]]; then
    TARGET_PATH="${COMPILE_ROOT}/output/linux/editor_pr${GAME_NAME}"
elif [[ $PLATFORM == 2 ]]; then
	TARGET_PATH="${COMPILE_ROOT}/output/mac/editor_pr${GAME_NAME}"
elif [[ $PLATFORM == 4 ]]; then
	TARGET_PATH="${COMPILE_ROOT}/output/raspberry/editor_pr${GAME_NAME}"
elif [[ $PLATFORM == 5 ]]; then
    TARGET_PATH="${COMPILE_ROOT}/output/windows/editor_pr${GAME_NAME}"
fi
cd ${GAME_NAME}/OneLife
./configure $PLATFORM

cd gameSource
if [[ $PLATFORM == 5 ]]; then export PATH="/usr/i686-w64-mingw32/bin:${PATH}"; fi
./makeEditor.sh

cd ../../..


##### Create Game Folder
mkdir -p ${TARGET_PATH}
cd ${TARGET_PATH}

##### Copy to Game Folder
if [[ $PLATFORM == 5 ]]; then cp -f ${COMPILE_ROOT}/${GAME_NAME}/OneLife/gameSource/EditOneLife.exe .; fi
if [[ $PLATFORM == 1 ]]; then cp -f ${COMPILE_ROOT}/${GAME_NAME}/OneLife/gameSource/EditOneLife .; fi

echo "Compile_make_only Done!"