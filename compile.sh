#!/bin/bash
set -e
AUTORUN=$(cat AUTORUN)
PLATFORM=$(cat PLATFORM_OVERRIDE)
DATA_NAME=$(cat DATA_NAME)
GAME_NAME=$(cat GAME_NAME)
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then PLATFORM=${1-5}; fi
if [[ $PLATFORM > 5 ]]; then
	echo "Usage: 1 for Linux, 2 for Mac, 3 for Windows on mingw, 4 for Raspberry, 5 for XCompiling for Windows (Default)"
	exit 1
fi
cd "$(dirname "${0}")/.."

COMPILE_ROOT=$(pwd)
if [[ $PLATFORM == 1 ]]; then
    TARGET_PATH="${COMPILE_ROOT}/output/linux/client"
elif [[ PLATFORM == 2 ]]; then
	TARGET_PATH="${COMPILE_ROOT}/output/mac/client"
elif [[ $PLATFORM == 4 ]]; then
	TARGET_PATH="${COMPILE_ROOT}/output/raspberry/client"
elif [[ $PLATFORM == 5 ]]; then
    TARGET_PATH="${COMPILE_ROOT}/output/windows/client"
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

cd ../../..


##### Create Game Folder
mkdir -p ${TARGET_PATH}
cd ${TARGET_PATH}

FOLDERS="animations categories ground music objects sounds sprites transitions"
TARGET="."
LINK="${COMPILE_ROOT}/DATA/${DATA_NAME}"
${COMPILE_ROOT}/miniOneLifeCompile/util/createLinks.sh $PLATFORM "$FOLDERS" $TARGET $LINK

FOLDERS="graphics otherSounds languages"
TARGET="."
LINK="${COMPILE_ROOT}/${GAME_NAME}/OneLife/gameSource"
${COMPILE_ROOT}/miniOneLifeCompile/util/createLinks.sh $PLATFORM "$FOLDERS" $TARGET $LINK


cp -rn "${COMPILE_ROOT}/${GAME_NAME}/OneLife/gameSource/settings" .
cp "${COMPILE_ROOT}/${GAME_NAME}/OneLife/gameSource/reverbImpulseResponse.aiff" .
cp "${COMPILE_ROOT}/${GAME_NAME}/OneLife/server/wordList.txt" .

cp "${COMPILE_ROOT}/DATA/${DATA_NAME}/dataVersionNumber.txt" .

# copying SDL.dll, clearCache script and discord_game_sdk library
if [[ $PLATFORM == 5 ]] && [ ! -f SDL.dll ]; then cp "${COMPILE_ROOT}/${GAME_NAME}/OneLife/build/win32/SDL.dll" .; fi
if [[ $PLATFORM == 5 ]] && [ ! -f clearCache.bat ]; then cp "${COMPILE_ROOT}/${GAME_NAME}/OneLife/build/win32/clearCache.bat" .; fi

if [ -d $DISCORD_SDK_PATH ]; then
	# windows: copy discord_game_sdk.dll into the output folder
	if [[ $PLATFORM == 5 ]]; then cp $DISCORD_SDK_PATH/lib/x86/discord_game_sdk.dll ./; fi
	# linux: copy discord_game_sdk.so into the output folder
	if [[ $PLATFORM == 1 ]]; then
		if [[ ! -f ./discord_game_sdk.so ]]; then
			sudo cp $DISCORD_SDK_PATH/lib/x86_64/discord_game_sdk.so ./
			sudo chmod a+r ./discord_game_sdk.so
		fi
	fi
fi


##### Copy to Game Folder and Run
if [[ $PLATFORM == 5 ]]; then
	rm -f OneLife.exe
	cp ../${GAME_NAME}/OneLife/gameSource/OneLife.exe .
	if [[ $AUTORUN == 1 ]]; then
        echo "Starting OneLife"
        cmd.exe /c OneLife.exe
    fi
fi
if [[ $PLATFORM == 1 ]]; then
	mv -f ../${GAME_NAME}/OneLife/gameSource/OneLife .
	if [[ $AUTORUN == 1 ]]; then
        echo "Starting OneLife"
        ./OneLife
    fi
fi
echo "Compile Done!"
