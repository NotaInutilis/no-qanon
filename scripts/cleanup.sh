#!/usr/bin/env bash

# Use this script to cleanup sources and normalize them to a list of domains while keeping comments.
# e.g.
# ./scripts/cleanup.sh

# Cleanup sources
## Special cleanup for imported sources of other formats (AdBlock, hosts, etc.)
find ./sources/_imported -type f -name "*.txt" -exec sed -ri 's/^[^#[:alnum:]]/#&/; s/^0\.0\.0\.0[[:space:]]*//i' {} \;
## Normalizes URLs into domains: lowercases, remove leading spaces, protocol (`x://`) `www.` subdomains, everything after `/`, only one space before `#`. Keeps comments intact
find ./sources -type f -name "*.txt" -exec sed -ri 'h; s/[^#]*//1; x; s/#.*//; s/.*/\L&/; s/^[[:space:]]*//i; s/^.*:\/\///i; s/^[.*]*//i; s/^www\.//i; s/\/[^[:space:]]*//i; s/[[:space:]].*$/ /i; G; s/(.*)\n/\1/' {} \;
## Remove duplicate domains from each source file (keeps repeated comments and empty lines for organization)
find ./sources -type f -name "*.txt" -exec bash -c '
    awk "(\$0 ~ /^[[:space:]]*#/ || NF == 0 || !seen[\$0]++)" "$0" > "$0_temp.txt";
    mv "$0_temp.txt" "$0";
' {} \;