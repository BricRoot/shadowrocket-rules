#!/bin/bash

set -e

REPO="https://github.com/johnshall/Shadowrocket-ADBlock-Rules-Forever.git"

rm -rf source

git clone --depth=1 "$REPO" source

find source -type f -name "*.conf" | while read file
do
    name=$(basename "$file")

    cp "$file" "$name"

    if grep -Eq "^\[(Rule|Rules)\]" "$name"; then

        echo "Update: $name"

        awk '
        BEGIN {inserted=0}

        /^\[(Rule|Rules)\]/ && inserted==0 {
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
        ' "$name" > "$name.tmp"

        mv "$name.tmp" "$name"

    else
        echo "Skip: $name"
    fi

done

rm -rf source
