#!/usr/bin/env bash

# Use this script to download and cleanup external blocklists.
# e.g.
# ./scripts/import.sh

# Download external blocklists
./scripts/download.sh < ./import/importlist.txt

# Copy to modified
cp -a ./import/original/. ./import/modified/

# Cleanup imported sources (Same code in update.sh)
## Special cleanup for imported sources of other formats (match, hosts, AdBlock, etc.)
find ./import/modified -type f -name "*.txt" -exec sed -ri 's/^\*\:\/\///i; s/^\*\.//i; s/^0\.0\.0\.0[[:space:]]*//i; s/^127\.0\.0\.1[[:space:]]*//i; s/^255\.255\.255\.255[[:space:]]*//i; s/^\:\:1[[:space:]]*//i; s/^fe80\:\:1\%lo0[[:space:]]*//i; s/^[[:space:]]*localhost[[:space:]]*$//i; s/^[[:space:]]*localhost.localdomain[[:space:]]*$//i; s/^[[:space:]]*local[[:space:]]*$//i; s/^[[:space:]]*broadcasthost[[:space:]]*$//i; s/^[^#[:alnum:]]/#&/' {} \;
## Normalizes URLs into domains: lowercases, remove leading spaces, protocol (`x://`) `www.` subdomains, everything after `/`, only one space before `#`. Keeps comments intact
find ./import/modified -type f -name "*.txt" -exec sed -ri 'h; s/[^#]*//1; x; s/#.*//; s/.*/\L&/; s/^[[:space:]]*//i; s/^.*:\/\///i; s/^[.*]*//i; s/^ww[w[:digit:]]\.//i; s/\/[^[:space:]]*//i; s/[[:space:]].*$/ /i; G; s/(.*)\n/\1/' {} \;
find ./import/modified -type f -name "*.txt" -exec sed -ri 's/^ww[w[:digit:]]\.//i' {} \; # Removing "www." twice because unmaintained imported lists are weird.
## Remove duplicate domains from each source file (keeps repeated comments and empty lines for organization)
find ./import/modified -type f -name "*.txt" -exec bash -c '
    awk "(\$0 ~ /^[[:space:]]*#/ || NF == 0 || !seen[\$0]++)" "$0" > "$0_temp.txt";
    mv "$0_temp.txt" "$0";
' {} \;

# Remove entries from the allowlist
find ./import/modified -type f -name "*.txt" -exec bash -c '
    grep -vxFf "./import/allowlist.txt" "$0" > "$0_temp.txt";
    mv "$0_temp.txt" "$0";
' {} \;

# Copy to sources
cp -a ./import/modified/. ./sources/_imported/