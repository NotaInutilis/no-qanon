#!/usr/bin/env bash

# Use this script to generate all the blocklists using the `.txt` files in the `sources` folder.
# e.g.
# ./scripts/update.sh

# Cleanup sources (same code in import.sh)
## Normalizes URLs into domains: lowercases, remove leading spaces, protocol (`x://`), `www.` subdomains, everything after `/`, only one space before `#`. Keeps comments intact
find ./sources -type f -name "*.txt" -exec sed -ri 'h; s/[^#]*//1; x; s/#.*//; s/.*/\L&/; s/^[[:space:]]*//i; s/^.*:\/\///i; s/^[.*]*//i; s/^ww[w[:digit:]]\.//i; s/\/[^[:space:]]*//i; s/[[:space:]].*$/ /i; G; s/(.*)\n/\1/' {} \;
## Remove duplicate domains from each source file (keeps repeated comments and empty lines for organization)
find ./sources -type f -name "*.txt" -exec bash -c '
    awk "(\$0 ~ /^[[:space:]]*#/ || NF == 0 || !seen[\$0]++)" "$0" > "$0_temp.txt";
    mv "$0_temp.txt" "$0";
' {} \;

# Combine all sources into a domains list
find ./sources -type f -iname "*.txt" -exec cat {} \; > domains.txt
## Fediverse domains list
find ./sources -type f -iname "*fediverse*.txt" -exec cat {} \; > fediverse_domains.txt

# Cleanup the domains list
## Remove comments, inline comments, spaces and empty lines
sed -i '/^#/d; s/#.*//; s/ //g; /^ *$/d' domains.txt fediverse_domains.txt
## Sort and remove duplicates
sort -u domains.txt > domains_temp.txt
mv domains_temp.txt domains.txt
sort -u fediverse_domains.txt > fediverse_domains_temp.txt
mv fediverse_domains_temp.txt fediverse_domains.txt

# Generate blocklists from the domains list
## For DNS filtering
### Hosts
python scripts/domains_to_hosts.py > hosts.txt
python scripts/domains_to_hosts_ipv6.py > hosts.txt.ipv6
### DNSmasq
python scripts/domains_to_dnsmasq.py > dnsmasq.txt

## For browser extensions
### Netsane
python scripts/domains_to_netsane.py > netsane.txt
### Adblock
python scripts/domains_to_adblock.py > adblock_temp.txt
cp ./headers/adblock.txt adblock.txt
cat adblock_temp.txt >> adblock.txt
rm adblock_temp.txt
### uBlacklist
python scripts/domains_to_ublacklist.py > ublacklist.txt

## Generate Fediverse blocklists
### Mastodon
python scripts/fediverse_domains_to_mastodon.py > mastodon_temp.txt
cp ./headers/mastodon.csv mastodon.csv
cat mastodon_temp.txt >> mastodon.csv
rm mastodon_temp.txt
### FediBlockHole
python scripts/fediverse_domains_to_fediblockhole.py > fediblockhole_temp.txt
cp ./headers/fediblockhole.csv fediblockhole.csv
cat fediblockhole_temp.txt >> fediblockhole.csv
rm fediblockhole_temp.txt