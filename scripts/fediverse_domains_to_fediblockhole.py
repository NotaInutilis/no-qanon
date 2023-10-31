# This script converts fediverse_domains.txt into a .csv format used by FediBlockHole.
# Adds a comment for this specific blocklist (No-QAnon)
# Usage:
#	python fediverse_domains_to_fediblockhole.py > fediblockhole.txt

text_file = open("fediverse_domains.txt", "r")
lines = text_file.readlines()
text_file.close()

for line in lines:
	print(line.strip() + 'suspend,No-QAnon blocklist,No-QAnon blocklist')