#!/bin/bash

### Top means oldest item!

touch .hash_stored
hash_stored="$(cat .hash_stored)"
hash_new="$(sha256sum --text latest-paste.txt)"

if [[ "$hash_stored" == "$hash_new" ]]; then
    echo "(appenddb.sh) [INFO] Already imported!"
    # exit 0
fi

sha256sum --text latest-paste.txt > .hash_stored

dbfn="db/year/$(TZ=UTC date +%Y).txt"
tac latest-paste.txt >> "$dbfn"

sort -u "$dbfn" > "$dbfn".1
mv "$dbfn".1 "$dbfn"
