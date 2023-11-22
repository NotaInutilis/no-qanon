#!/usr/bin/env bash

# Use this script to import external blocklists from a list formatted as "file.txt url".
# e.g.
# ./scripts/import.sh < list.md

while read FILE URL; do
    wget -O "$FILE" -- "$URL"
done

# Cleanup sources
./scripts/cleanup.sh