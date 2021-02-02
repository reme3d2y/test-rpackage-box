#!/bin/bash

# выхожу, если одна из команд завершилась неудачно
set -e

git checkout master
git branch -u origin/master
git fetch --tags

# поднимаю версию во всех подпакетах
lerna version --conventional-commits --no-commit-hooks --amend --yes
# публикую все подпакеты
lerna publish from-git --yes
# отправляю изменения на github
git push --follow-tags
