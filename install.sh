#!/bin/bash

EOLC_version=$(curl https://raw.githubusercontent.com/X-Lives/EasierOLCompile/main/VERSION)
if [[ $EOLC_time == "" ]];then
    EOLC_time=$(date "+%Y-%m-%d %H:%M:%S")
fi
EOLC_install=1

# echo "
# _//      _//      _//                                     
#  _//   _//        _//       _/                            
#   _// _//         _//         _//     _//   _//     _//// 
#     _//     _/////_//      _// _//   _//  _/   _// _//    
#   _// _//         _//      _//  _// _//  _///// _//  _/// 
#  _//   _//        _//      _//   _/_//   _/            _//
# _//      _//      _////////_//    _//      _////   _// _//
# "
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
echo -e "\033[32mEasierOLCompile\033[0m version \033[33m${EOLC_version}\033[0m(create ${EOLC_time})"
echo ""

read -p "Next?[Y/n]" EOLC_re
EOLC_re=$(echo $EOLC_re | tr '[:upper:]' '[:lower:]')
if [[ $EOLC_re = *n* ]];then
    exit 1
fi
echo ""

while [[ "${ELOC_dir_ok}" != 1 ]];do
    EOLC_dir=$(pwd)
    read -p "EOLC_Directory[${EOLC_dir}|ENTER:default]: " EOLC_dir_read
    if [ -n "${EOLC_dir_read}" ];then
        # if not empty.
        EOLC_dir=${EOLC_dir_read}
    fi
    if [ ! -d "${EOLC_dir}" ];then
        echo -e "\033[31mError: This is not the valid directory!\033[0m"
    elif [ "$(ls -A "$EOLC_dir" | grep -v ^install\.sh$)" ];then
        echo -e "\033[31mError: This is not the empty directory!\033[0m"
    else
        ELOC_dir_ok=1
    fi
done
while [[ "${EOLC_ds_ok}" != 1 ]];do
    EOLC_ds=1
    read -p "EOLC_Download_Source[1:Github|2:Gitee|ENTER:Github]: " EOLC_ds_read
    if [ -n "${EOLC_ds_read}" ];then
        # if not empty.
        EOLC_ds=${EOLC_ds_read}
    fi
    if [[ "${EOLC_ds}" == 1 ]] || [[ "${EOLC_ds}" == 2 ]];then
        EOLC_ds_ok=1
    else
        echo -e "\033[31mError: ${EOLC_ds} is not the valid number!\033[0m"
    fi
done
REPO_SET=""
if [[ "${EOLC_ds}" == 1 ]];then
    REPO_SET=2
    EOLC_ds_link="https://github.com/X-Lives/EasierOLCompile.git"
    SPEEDEDUP_LINK=""
    CODE_REPO="https://github.com/X-Lives/X-Lives.git"
    CODE_BRANCH=""
    DATA_REPO="https://github.com/X-Lives/XLivesData.git"
    DATA_BRANCH=""
    GEMS_REPO="https://github.com/X-Lives/X-minorGems.git"
    GEMS_BRANCH=""
elif [[ "${EOLC_ds}" == 2 ]];then
    REPO_SET=3
    EOLC_ds_link=""
fi

echo ""
echo "---------------------------"
echo "EOLC_Directory: ${EOLC_dir}"
echo "EOLC_Download_Source: ${EOLC_ds}"
echo "EOLC_link: ${EOLC_ds_link}"
echo "---------------------------"
read -p "OK?[ENTER:next]"
echo "\033[32mWill start...\033[0m"
read -t 1 -p "5s"
read -t 1 -p "4s"
read -t 1 -p "3s"
read -t 1 -p "2s"
read -t 1 -p "1s"
echo ""
echo ""
echo ""

sudo apt-get update
echo ""
sudo apt-get install -y git
echo ""
cd "${EOLC_dir}"
git clone "${EOLC_ds_link}" miniOneLifeCompile
cd miniOneLifeCompile
echo "${EOLC_time}" > CREATETIME
echo "0" >> AUTORUN
chmod +x getDependencies.sh
chmod +x cloneRepos.sh
echo ""
./getDependencies.sh
echo ""
./cloneRepos.sh $REPO_SET