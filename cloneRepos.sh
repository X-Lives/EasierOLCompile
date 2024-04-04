#!/bin/bash
set -e

DATA_NAME=$(cat DATA_NAME)
GAME_NAME=$(cat GAME_NAME)
EOLC_cr_dir_check=0 # CloneRepos.sh Git update.

cd "$(dirname "${0}")/.."

if [[ $1 == "" ]];then
    REPO_SET=""
else
    REPO_SET=$1
fi
if [[ ${REPO_SET} == "" ]]; then
    # This if means that if this file is executed alone, with no arguments passed in, this default argument will be used.
    SPEEDEDUP_LINK=""
    BRANCH=0
    CODE_REPO="https://github.com/X-Lives/X-Lives.git"
    CODE_BRANCH=""
    DATA_REPO="https://github.com/X-Lives/XLivesData.git"
    DATA_NAME="XLivesData"
    DATA_BRANCH=""
    GEMS_REPO="https://github.com/X-Lives/X-minorGems.git"
    GEMS_BRANCH=""
elif [[ ${REPO_SET} == "1" ]]; then
    echo "--------ROPES-SETUP--------"
    read -p "Use BRANCH?[Y/N]: " BRANCH_read
    read -p "Use SPEEDEDUP_LINK?[Y/N]" SPEEDEDUP_LINK_read
    SPEEDEDUP_LINK_read=$(echo $SPEEDEDUP_LINK_read | tr '[:upper:]' '[:lower:]')
    if [[ $SPEEDEDUP_LINK_read == *y* ]];then
        read -p "SPEEDEDUP_LINK: " SPEEDEDUP_LINK
    fi
    read -p "CODE_REPO: " CODE_REPO
    read -p "DATA_REPO: " DATA_REPO
    read -p "GEMS_REPO: " GEMS_REPO
    BRANCH_read=$(echo $BRANCH_read | tr '[:upper:]' '[:lower:]')
    if [[ "${BRANCH_read}" == *y* ]];then
        read -p "CODE_BRANCH: " CODE_BRANCH
        read -p "DATA_BRANCH: " DATA_BRANCH
        read -p "GEMS_BRANCH: " GEMS_BRANCH
    fi
    echo "---------------------------"
    read -p "OK?[Y/N]: " EOLC_cr_read
    EOLC_cr_read=$(echo $EOLC_cr_read | tr '[:upper:]' '[:lower:]')
    if [[ $EOLC_cr_ok == *n* ]];then
        exit 1
    fi
elif [[ ${REPO_SET} == "2" ]]; then
    SPEEDEDUP_LINK=""
    BRANCH=0
    CODE_REPO="https://github.com/X-Lives/X-Lives.git"
    CODE_BRANCH=""
    DATA_REPO="https://github.com/X-Lives/XLivesData.git"
    DATA_NAME="XLivesData"
    DATA_BRANCH=""
    GEMS_REPO="https://github.com/X-Lives/X-minorGems.git"
    GEMS_BRANCH=""
fi

mkdir -p ${GAME_NAME}
cd ${GAME_NAME}
if [[ -d "${GAME_NAME}" ]]; then
    EOLC_cr_dir_check=1
fi
if [[ ! -d OneLife ]]; then
    if [ ${BRANCH} -eq 1 ]; then
        git clone -b ${CODE_BRANCH} ${SPEEDEDUP_LINK}${CODE_REPO} OneLife
    else
        git clone ${SPEEDEDUP_LINK}${CODE_REPO} OneLife
    fi
fi
if [[ ! -d minorGems ]]; then
    if [ ${BRANCH} -eq 1 ]; then
        git clone -b ${GEMS_BRANCH} ${SPEEDEDUP_LINK}${GEMS_REPO} minorGems
    else
        git clone ${SPEEDEDUP_LINK}${GEMS_REPO} minorGems
    fi
fi

cd ..
mkdir -p DATA
cd DATA

if [[ ! -d "${DATA_NAME}" ]]; then
    if [ ${BANCH} -eq 1 ]; then
        git clone -b ${DATA_BRANCH} ${SPEEDEDUP_LINK}${DATA_REPO} "${DATA_NAME}"
    else
        git clone ${SPEEDEDUP_LINK}${DATA_REPO} "${DATA_NAME}"
    fi
fi
