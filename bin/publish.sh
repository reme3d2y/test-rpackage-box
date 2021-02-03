#!/bin/bash

# выхожу, если одна из команд завершилась неудачно
set -e

git remote set-url origin https://reme3d2y:$GITHUB_TOKEN@github.com/reme3d2y/test-rpackage-box.git
git checkout master
git branch -u origin/master
git fetch --tags
git status


# поднимаю версию во всех подпакетах
lerna version --conventional-commits --no-commit-hooks --amend --yes
# публикую все подпакеты
# lerna publish from-git --yes

git status

git pull --rebase
# отправляю изменения на github
git push
