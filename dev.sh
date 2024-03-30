#!/bin/bash
set -e

EOLC_version=$(curl https://raw.githubusercontent.com/X-Lives/EasierOLCompile/main/VERSION)
EOLC_time=$(cat CREATETIME)
if [[ $EOLC_time == "" ]];then
    EOLC_time=$(date "+%Y-%m-%d %H:%M:%S")
fi

echo "
  ______             _                ____   _         _____                          _  _       
 |  ____|           (_)              / __ \ | |       / ____|                        (_)| |      
 | |__    __ _  ___  _   ___  _ __  | |  | || |      | |      ___   _ __ ___   _ __   _ | |  ___ 
 |  __|  / _\` |/ __|| | / _ \| '__| | |  | || |      | |     / _ \ | '_ \` _ \ | '_ \ | || | / _ \\
 | |____| (_| |\__ \| ||  __/| |    | |__| || |____  | |____| (_) || | | | | || |_) || || ||  __/
 |______|\__,_||___/|_| \___||_|     \____/ |______|  \_____|\___/ |_| |_| |_|| .__/ |_||_| \___|
                                                                              | |                
                                                                              |_|                
"
echo -e "\033[32mEasierOLCompile\033[0m Command:$0 version \033[33m${EOLC_version}\033[0m(create ${EOLC_time})"
echo ""

echo "---------------------------"
echo "1 Linux"
echo "2 Mac"
echo "3 Windows on mingw"
echo "4 Raspberry"
echo "5 XCompiling for Windows (Default)"
echo "---------------------------"
while [[ "${PLATFORM_DEV_ok}" != 1 ]];do
    PLATFORM_DEV=5
    read -p "Type: " PLATFORM_DEV
    if [ -n "${EPLATFORM_DEV_read}" ];then
        # if not empty.
        PLATFORM_DEV=${PLATFORM_DEV_read}
    fi
    if [[ $EPLATFORM_DEV !> 5 ]]; then
        PLATFORM_DEV_ok=1
    else
        echo -e "\033[31mError: ${PLATFORM_DEV} is not the valid number!\033[0m"
    fi
done

./cleanOldBuildsAndOptionallyCaches.sh
./compile.sh "${PLATFORM_DEV}"