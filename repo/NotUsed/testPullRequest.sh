#!/bin/bash
set -e
COMP_NAME=$(basename "$PWD")
# Not Sure.
if [[ ${COMP_NAME} == "" ]]; then
    COMP_NAME=miniOneLifeCompile
fi
cd "$(dirname "${0}")/../.."

repo=$1
remote=$2
prNum=$3

### Clean repo first
./"${COMP_NAME}"/repo/ensureClean.sh $1

### Fetch and checkout the PR as a new local branch
git -C $repo fetch $remote pull/$prNum/head:${remote}_pr_$prNum
git -C $repo checkout ${remote}_pr_$prNum