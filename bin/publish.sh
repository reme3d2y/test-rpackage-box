#!/bin/bash

# выхожу, если одна из команд завершилась неудачно
set -e

git remote add origin "https://reme3d2y:$PERMISSION_GITHUB_TOKEN@github.com/test-rpackage-box.git"
git checkout master
git branch -u origin/master
git fetch --tags
git remote -v


# поднимаю версию во всех подпакетах
lerna version --conventional-commits --no-commit-hooks --amend --yes
# публикую все подпакеты
lerna publish from-git --yes
# отправляю изменения на github
git push --follow-tags
