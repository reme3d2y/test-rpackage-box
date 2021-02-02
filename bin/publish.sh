#!/bin/bash

# выхожу, если одна из команд завершилась неудачно
set -e

git checkout master
git fetch --tags

# поднимаю версию во всех подпакетах
lerna version --no-push --no-commit-hooks
# публикую все подпакеты
lerna publish from-git
# отправляю изменения на github
git push --follow-tags
