#!/bin/bash
# выхожу, если одна из команд завершилась неудачно
set -e

# удаляю билды
yarn clean

# устанавливаем ограничение на количество параллельных процессов при сборке (default - 10)
CONCURRENCY=${BUILD_CONCURRENCY:=10}

echo "start build on $CONCURRENCY parallel process"

# собираю все подпакеты, за исключением css-пакетов (vars, themes)
lerna exec --concurrency $CONCURRENCY \
    --ignore test-rpackage-box-vars \
    --ignore test-rpackage-box-themes \
    -- $(pwd)/bin/rollup.sh

# собираю css пакеты
copy_css="yarn copyfiles -u 1 \"src/**/*.css\" dist"
copy_package="yarn copyfiles package.json dist"
lerna exec \
    --scope test-rpackage-box-vars \
    --scope test-rpackage-box-themes \
    -- "$copy_css && $copy_package"

# собираю пакет themes
lerna exec --scope test-rpackage-box-themes -- node $(pwd)/bin/build-themes.js

# копирую собранные css пакеты в корневой пакет
copy_to_root="mkdir -p ../root/\${PWD##*/} && cp -r dist/ ../root/\${PWD##*/}"
lerna exec \
    --scope test-rpackage-box-vars \
    --scope test-rpackage-box-themes \
    -- $copy_to_root

# копирую package.json в сборку корневого пакета
cp package.json packages/root/package.json

# делаю корневой пакет публичным
yarn json -f packages/root/package.json -I -e "delete this.private" -e "delete this.workspaces"
