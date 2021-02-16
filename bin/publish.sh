#!/bin/bash

set -e

# Релизим рут-пакет с помощью semantic-release.
semantic_output=$(yarn semantic-release)

echo $semantic_output

# Проеряем, что semantic-release зарелизил рут-пакет.
# Пока не знаю, как это можно сделать по-нормальному.
if [[ $semantic_output =~ "Publishing version" ]]
then
    git remote set-url origin https://semantic-release-bot:$GITHUB_TOKEN@github.com/reme3d2y/test-rpackage-box.git
    git checkout master
    git pull origin master --rebase
    git fetch --tags

    if [ -z $(lerna changed) ]; then
        echo "There are no relevant changes, so no new versions are released."
    else
        lerna version --conventional-commits --no-commit-hooks --yes
        git push origin master
        lerna publish from-git --yes
    fi
else
    exit 0
fi
