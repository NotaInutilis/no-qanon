#!/usr/bin/env bash

# Use this script to download external blocklists from a non-txt list formatted as "file.txt|url" to the sources/_imported/ folder.
# e.g.
# ./scripts/download.sh < list.md

IFS='|'
while read FILE URL; do
    wget -O ./sources/_imported/"$FILE" -- "$URL"
done