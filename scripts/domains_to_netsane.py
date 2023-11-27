# This script converts domains.txt into a format used by netsane.
# Usage:
#	python domains_to_netsane.py > netsane.txt

text_file = open("domains.txt", "r")
lines = text_file.readlines()
text_file.close()

for line in lines:
	print('"*://*.' + line.strip() + '/*",')

