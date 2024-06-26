#!/bin/bash
set -e
PLATFORM=$(cat settings/PLATFORM_OVERRIDE)
GAME_NAME=$(cat settings/GAME_NAME)
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then PLATFORM=${1-1}; fi
if [[ $PLATFORM != 1 ]] && [[ $PLATFORM != 5 ]]; then
	echo "Usage: 1 for Linux (Default), 5 for XCompiling for Windows"
	exit 1
fi
cd "$(dirname "${0}")/.."
COMPILE_ROOT=$(pwd)
if [[ $PLATFORM == 1 ]]; then
        TARGET_PATH="${COMPILE_ROOT}/output/linux/server_${GAME_NAME}"
else
        TARGET_PATH="${COMPILE_ROOT}/output/windows/server_${GAME_NAME}"
fi

cd ${TARGET_PATH}
if [[ $PLATFORM == 5 ]]; then cmd.exe /c  OneLifeServer.exe; fi
if [[ $PLATFORM == 1 ]]; then ./OneLifeServer; fi
