#!/bin/bash

mkdir -p .workdir

touch .workdir/item.html

function build_html_item() {
    cat "$tmpl_path" > .workdir/item.html
    sed -i "s|PICURL|$picurl|g" .workdir/item.html
    sed -i "s|APPID|$appid|g" .workdir/item.html
    sed -i "s|RELDATE|$date|g" .workdir/item.html
    sed -i "s|GAMETITLE|$title|g" .workdir/item.html
    cat .workdir/item.html >> .workdir/list.html
}

echo '' > .workdir/list.html

function __fetchAll() {
    counter=0
    while read -r line; do
        echo "line=$line"
        date="$(cut -d^ -f1 <<< "$line")"
        appid="$(cut -d^ -f2 <<< "$line")"
        title="$(cut -d^ -f3- <<< "$line")"
        curl "https://store.steampowered.com/api/appdetails?appids=$appid" > .workdir/appdetails-curl.txt || return 5
        picurl="$(jq -r     ".[\"$appid\"].data.header_image"   .workdir/appdetails-curl.txt)"
        sleep 6
        tmpl=small
        if grep -sq "$appid" featured-apps.txt || [[ "$counter" == 0 ]]; then
            tmpl=large
        fi
        tmpl_path="wwwsrc/comp/$tmpl.html"
        build_html_item

        counter=$((counter+1))
    done < /dev/stdin
}

__fetchAll < db/dbsnapshot.txt


node sh/makehome.js
