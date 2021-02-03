#!/bin/bash

# выхожу, если одна из команд завершилась неудачно
set -e

git remote set-url origin https://reme3d2y:$GITHUB_TOKEN@github.com/reme3d2y/test-rpackage-box.git
git checkout master
git fetch --tags

# поднимаю версию во всех подпакетах
lerna version --conventional-commits --no-commit-hooks --yes

# отправляю изменения на github
git push origin master

# публикую все подпакеты
lerna publish from-git --yes
