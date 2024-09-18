#!/bin/bash

while read -r line; do
    echo "line=$line"
    date="$(cut -d^ -f1 <<< "$line")"
    appid="$(cut -d^ -f2 <<< "$line")"
    title="$(cut -d^ -f3- <<< "$line")"
    dbpath="db/app/${appid:0:2}/$appid.txt"
    mkdir -p "db/app/${appid:0:2}"
    echo "$line" > "$dbpath"
done < latest-paste.txt
