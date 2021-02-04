#!/bin/bash

set -e

git remote set-url origin https://semantic-release-bot:$GITHUB_TOKEN@github.com/reme3d2y/test-rpackage-box.git
git checkout master
git pull origin master --rebase
git fetch --tags

if [ -z $(lerna changed) ]
then
    echo "There are no relevant changes, so no new versions are released."
else
    lerna version --conventional-commits --no-commit-hooks --yes
    git push origin master
    lerna publish from-git --yes
fi
