#!/bin/bash
set -e
PLATFORM=$(cat settings/PLATFORM_OVERRIDE)
DATA_NAME=$(cat settings/DATA_NAME)
GAME_NAME=$(cat settings/GAME_NAME)
COMP_NAME=$(basename "$PWD")
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then PLATFORM=${1-5}; fi
if [[ $PLATFORM > 5 ]]; then
	echo "Usage: 1 for Linux, 2 for Mac, 3 for Windows on mingw, 4 for Raspberry, 5 for XCompiling for Windows (Default)"
	exit 1
fi
cd "$(dirname "${0}")/.."

COMPILE_ROOT=$(pwd)
if [[ $PLATFORM == 1 ]]; then
    TARGET_PATH="${COMPILE_ROOT}/output/linux/client_pr${GAME_NAME}"
elif [[ $PLATFORM == 2 ]]; then
	TARGET_PATH="${COMPILE_ROOT}/output/mac/client_pr${GAME_NAME}"
elif [[ $PLATFORM == 4 ]]; then
	TARGET_PATH="${COMPILE_ROOT}/output/raspberry/client_pr${GAME_NAME}"
elif [[ $PLATFORM == 5 ]]; then
    TARGET_PATH="${COMPILE_ROOT}/output/windows/client_pr${GAME_NAME}"
fi
DISCORD_SDK_PATH="${COMPILE_ROOT}/dependencies/discord_game_sdk"
MINOR_GEMS_PATH="${COMPILE_ROOT}/${GAME_NAME}/minorGems"

##### Configure and Make
cd ${GAME_NAME}/OneLife
if [ -d $DISCORD_SDK_PATH ]; then
	./configure $PLATFORM "$MINOR_GEMS_PATH" --discord_sdk_path "${DISCORD_SDK_PATH}"
else
	./configure $PLATFORM
fi
cd gameSource
if [[ $PLATFORM == 5 ]]; then export PATH="/usr/i686-w64-mingw32/bin:${PATH}"; fi
make

pwd
cd ../../..
pwd


##### Create Game Folder
mkdir -p ${TARGET_PATH}
cd ${TARGET_PATH}
pwd
##### Copy to Game Folder and Run
if [[ $PLATFORM == 5 ]]; then
	rm -f OneLife.exe
	cp ${COMPILE_ROOT}/${GAME_NAME}/OneLife/gameSource/OneLife.exe .
fi
if [[ $PLATFORM == 1 ]]; then
	mv -f ${COMPILE_ROOT}/${GAME_NAME}/OneLife/gameSource/OneLife .
fi
echo "Compile_make_only Done!"
