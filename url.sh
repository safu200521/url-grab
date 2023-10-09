#!/bin/bash

echo "Enter target URL or path to file containing list of URLs:"
read input

if [[ -f $input ]]; then
    echo "Running commands on list of URLs..."
    katana -u $input --aff -jc -kf all -d 5 > urls/kat.txt
    cat $input | gau -providers wayback,commoncrawl,otx,urlscan --subs > urls/gau.txt
    gospider -S $input -d 4 --js -a --subs -q > urls/gos.txt
else
    echo "Running commands on single URL..."
    katana -u $input --aff -jc -kf all -d 5 > urls/kat.txt
    echo $input | gau --providers wayback,commoncrawl,otx,urlscan --subs > urls/gau.txt
    gospider -s $input -d 4 --js -a --subs -q > urls/gos.txt
fi

echo "Done. Check kat.txt, gau.txt, and gos.txt for the output."
