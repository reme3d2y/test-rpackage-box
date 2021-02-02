#!/bin/bash

# выхожу, если одна из команд завершилась неудачно
set -e

git remote set-url origin https://reme3d2y:$GITHUB_TOKEN@github.com/test-rpackage-box.git
git checkout master
git branch -u origin/master
git fetch --tags
git remote -v
# git config --global url."git@github.com:".insteadOf "https://github.com/"


# поднимаю версию во всех подпакетах
lerna version --conventional-commits --no-commit-hooks --amend --yes
# публикую все подпакеты
lerna publish from-git --yes
# отправляю изменения на github
git push --follow-tags
