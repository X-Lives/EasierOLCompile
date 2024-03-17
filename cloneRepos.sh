#!/bin/bash
set -e
cd "$(dirname "${0}")/.."

if [ -z ${CONFIG} ] || [ ${CONFIG} -eq 0 ]; then
    SPEEDEDUP_LINK=""
    CODE_REPO="https://github.com/X-Lives/X-Lives.git"
    CODE_BRANCH=""
    DATA_REPO="https://github.com/X-Lives/XLivesData.git"
    DATA_BRANCH=""
    GEMS_REPO="https://github.com/X-Lives/X-minorGems.git"
    GEMS_BRANCH=""
fi

if [[ ! -d OneLife ]]; then
    if [ ${BRANCH} -eq 1 ]; then
        git clone -b ${CODE_BRANCH} ${SPEEDEDUP_LINK}${CODE_REPO} OneLife
    else
        git clone ${SPEEDEDUP_LINK}${CODE_REPO} OneLife
    fi
fi
if [[ ! -d OneLifeData7 ]]; then
    if [ ${BANCH} -eq 1 ]; then
        git clone -b ${DATA_BRANCH} ${SPEEDEDUP_LINK}${DATA_REPO} OneLifeData7
    else
        git clone ${SPEEDEDUP_LINK}${DATA_REPO} OneLifeData7
    fi
fi
if [[ ! -d minorGems ]]; then
    if [ ${BRANCH} -eq 1 ]; then
        git clone -b ${GEMS_BRANCH} ${SPEEDEDUP_LINK}${GEMS_REPO} minorGems
    else
        git clone ${SPEEDEDUP_LINK}${GEMS_REPO} minorGems
    fi
fi
