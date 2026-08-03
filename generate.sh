#!/bin/bash

set -e

rm -rf source
mkdir source

git clone --depth=1 https://github.com/johnshall/Shadowrocket-ADBlock-Rules-Forever.git source

mkdir -p output

find source -name "*.conf" | while read file
do
    name=$(basename "$file")
    
    cp "$file" "output/$name"

    if grep -q "^\[Rules\]" "output/$name"; then
        sed -i "/^\[Rules\]/r custom.rules" "output/$name"
    elif grep -q "^\[Rule\]" "output/$name"; then
        sed -i "/^\[Rule\]/r custom.rules" "output/$name"
    fi

done
