#!/bin/bash

set -e

REPO="https://github.com/johnshall/Shadowrocket-ADBlock-Rules-Forever.git"

echo "Download upstream rules..."

rm -rf source
git clone --depth=1 "$REPO" source

echo "Generate conf files..."

find source -type f -name "*.conf" | while read file
do
    name=$(basename "$file")
    echo "Processing: $name"

    cp "$file" "$name"

    if grep -Eq "^\[(Rule|Rules)\]" "$name"; then
        echo "Insert custom rules: $name"

        awk '
        BEGIN {inserted=0}

        /^\[(Rule|Rules)\]/ && inserted==0 {
            print
            while ((getline line < "custom.list") > 0)
                print line
            close("custom.list")
            inserted=1
            next
        }

        {
            print
        }
        ' "$name" > "$name.tmp"

        mv "$name.tmp" "$name"
    else
        echo "Skip(no Rule): $name"
    fi
done

rm -rf source

echo "Done."
