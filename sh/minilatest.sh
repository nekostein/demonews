#!/bin/bash

### Get latest items from year/*.txt

### Top means latest item!

find db/year -name '*.txt' | sort -u | tail -n2 | xargs cat | sort -u | tail -n 100 | tac /dev/stdin > db/dbsnapshot.txt
