#!/bin/bash

# выхожу, если одна из команд завершилась неудачно
set -e

git remote set-url origin https://reme3d2y:$GITHUB_TOKEN@github.com/reme3d2y/test-rpackage-box.git
git checkout master
git fetch --tags
git status
git branch
git log -5
git remote show origin


# поднимаю версию во всех подпакетах
lerna version --conventional-commits --no-commit-hooks --amend --yes

# отправляю изменения на github
git push origin master

# публикую все подпакеты
# lerna publish from-git --yes
