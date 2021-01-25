#!/bin/bash

# удаляем неиспользуемые css-переменные из сборки в root-пакете
node bin/purgecss.js

# удаляем неиспользуемые css-переменные из сборки во всех подпакетах
lerna exec --parallel \
    --ignore test-rpackage-box-vars \
    --ignore test-rpackage-box-themes \
    -- node ../../bin/purgecss.js
