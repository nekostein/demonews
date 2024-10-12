#!/bin/bash

case $1 in
    c | copy )
        xclip -selection clipboard < inwebconsole.js
        echo "[INFO] Script copied; run in https://steamdb.info/upcoming/?lastweek"
        ;;
    r | recv)
        xclip -selection clipboard -o | sort -u > latest-paste.txt
        ./make.sh build
        ;;
    b | build )
        bash sh/importer.sh
        bash sh/appenddb.sh
        bash sh/minilatest.sh
        bash sh/sitebuild.sh
        ;;
    sb | sitebuild)
        bash sh/sitebuild.sh
        realpath wwwdist/index.html
        ;;
    cf | deploy )
        wrangler pages deploy wwwdist --project-name="demonews" --commit-dirty=true --branch=master && printf "Upload finished\n\n"
        ;;
    rrr )
        ./make.sh r
        ./make.sh cf &
        ;;
esac
