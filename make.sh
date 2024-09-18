#!/bin/bash

case $1 in
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
    cf | deploy )
        wrangler pages deploy wwwdist --project-name="demonews" --commit-dirty=true --branch=master
        ;;
esac
