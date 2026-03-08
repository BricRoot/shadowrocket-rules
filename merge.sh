#!/bin/bash

set -e

echo "Downloading rules..."

curl -L https://johnshall.github.io/Shadowrocket-ADBlock-Rules-Forever/sr_cnip_ad.conf -o cnip.conf
curl -L https://johnshall.github.io/Shadowrocket-ADBlock-Rules-Forever/sr_top500_banlist_ad.conf -o top500.conf

insert_rules () {
awk '
/^\[Rule\]/ {
    print
    while ((getline line < "insert_rules.txt") > 0) print line
    close("insert_rules.txt")
    next
}
{print}
' "$1" > "$2"
}

echo "Merging..."

insert_rules cnip.conf final_cnip.conf
insert_rules top500.conf final_top500.conf

rm -f cnip.conf top500.conf

echo "Done"
