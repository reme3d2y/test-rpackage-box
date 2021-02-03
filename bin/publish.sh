#!/bin/bash

# выхожу, если одна из команд завершилась неудачно
set -e

git remote set-url origin https://reme3d2y:$GITHUB_TOKEN@github.com/reme3d2y/test-rpackage-box.git
git fetch --tags --update-head-ok https://reme3d2y:$GITHUB_TOKEN@github.com/reme3d2y/test-rpackage-box.git
git status
git branch


# поднимаю версию во всех подпакетах
lerna version --conventional-commits --no-commit-hooks --amend --yes

# отправляю изменения на github
# git push

# публикую все подпакеты
# lerna publish from-git --yes
