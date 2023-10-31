# This script converts fediverse_domains.txt into a .csv format used by Mastodon.
# Adds a comment for this specific blocklist (No-QAnon)
# Usage:
#	python fediverse_domains_to_mastodon.py > mastodon.txt

text_file = open("fediverse_domains.txt", "r")
lines = text_file.readlines()
text_file.close()

for line in lines:
	print(line.strip() + ',suspend,false,false,No-QAnon blocklist,false')
