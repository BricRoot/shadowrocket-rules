#!/bin/bash

set -e

REPO="https://github.com/johnshall/Shadowrocket-ADBlock-Rules-Forever.git"

rm -rf source output

git clone --depth=1 "$REPO" source

mkdir -p output

find source -type f -name "*.conf" | while read file
do
    # 获取相对路径，保持目录结构
    relative="${file#source/}"

    target="output/$relative"

    mkdir -p "$(dirname "$target")"

    cp "$file" "$target"

    # 存在 [Rules] 才插入
    if grep -q "^\[Rules\]" "$target"; then

        echo "Updating: $relative"

        awk '
        BEGIN {inserted=0}
        /^\[Rules\]/ && inserted==0 {
            print
            while ((getline line < "custom.rules") > 0)
                print line
            close("custom.rules")
            inserted=1
            next
        }
        {
            print
        }
        ' "$target" > "$target.tmp"

        mv "$target.tmp" "$target"

    else
        echo "Skip: $relative"
    fi

done
