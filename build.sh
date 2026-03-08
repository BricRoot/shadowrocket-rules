#!/bin/bash
set -e

echo "Downloading source rules..."

curl -L https://johnshall.github.io/Shadowrocket-ADBlock-Rules-Forever/sr_cnip_ad.conf -o source_cnip.conf
curl -L https://johnshall.github.io/Shadowrocket-ADBlock-Rules-Forever/sr_top500_banlist_ad.conf -o source_top500.conf

insert_rules() {
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

echo "Building rules..."

insert_rules source_cnip.conf sr_cnip_ad_custom.conf
insert_rules source_top500.conf sr_top500_ad_custom.conf

rm -f source_cnip.conf source_top500.conf

echo "Done"
