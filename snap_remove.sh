#!/bin/sh
set -eu
snap list --all |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
        done
