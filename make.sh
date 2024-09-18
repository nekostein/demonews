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
    deploy )
        wrangler 
        ;;
esac
