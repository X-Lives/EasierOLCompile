#!/bin/bash
set -e
cd "$(dirname "${0}")/.."

SPEEDEDUP_LINK=""
CODE_REPO="https://github.com/X-Lives/X-Lives.git"
DATA_REPO="https://github.com/X-Lives/XLivesData.git"
GEMS_REPO="https://github.com/X-Lives/X-minorGems.git"

if [[ ! -d OneLife ]]; then git clone ${SPEEDEDUP_LINK}${CODE_REPO} OneLife; fi
if [[ ! -d OneLifeData7 ]]; then git clone ${SPEEDEDUP_LINK}${DATA_REPO} OneLifeData7; fi
if [[ ! -d minorGems ]]; then git clone ${SPEEDEDUP_LINK}${GEMS_REPO} minorGems; fi
