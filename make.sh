#!/bin/bash

case $1 in
    db/year/*.txt )
        ### Convert year TXT to TOML
        while read -r line; do
            printf '[[entry]]
timestamp = %s
appid = "%s"
title = "%s"\n' "$(cut -d^ -f1 <<< "$line")" "$(cut -d^ -f2 <<< "$line")" "$(cut -d^ -f3- <<< "$line")"
        done < "$1" > "$1.toml"
        tomlq .entry "$1.toml" > "$1.json"
        ;;
    c | copy )
        xclip -selection clipboard < inwebconsole.js
        echo "[INFO] Script copied; run in https://steamdb.info/upcoming/?lastweek"
        ;;
    r | recv)
        xclip -selection clipboard -o | sort -u > latest-paste.txt
        ./make.sh build || exit 1
        ;;
    b | build )
        bash sh/importer.sh || exit 1
        bash sh/appenddb.sh || exit 1
        bash sh/minilatest.sh || exit 1
        bash sh/sitebuild.sh || exit 1
        ;;
    sb | sitebuild)
        bash sh/sitebuild.sh
        realpath wwwdist/index.html
        ;;
    cf | deploy )
        wrangler pages deploy wwwdist --project-name="demonews" --commit-dirty=true --branch=master && printf "Upload finished\n\n"
        ;;
    rrr )
        ./make.sh r &&
        ./make.sh cf || exit 1
        ;;
esac
