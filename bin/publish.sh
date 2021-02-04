#!/bin/bash

# выхожу, если одна из команд завершилась неудачно
set -e

git remote set-url origin https://semantic-release-bot:$GITHUB_TOKEN@github.com/reme3d2y/test-rpackage-box.git
git checkout master
git pull origin master
git fetch --tags

changed_packages='$(lerna changed)'

# поднимаю версию во всех подпакетах
lerna version --conventional-commits --no-commit-hooks --yes

git push origin master

if [ -z "$changed_packages" ]; then
    echo "There are no relevant changes, so no new versions are released."
else
    echo "Publish subpackages:"
    echo $changed_packages
    lerna publish from-git --yes
fi
