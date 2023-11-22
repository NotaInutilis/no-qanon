#!/usr/bin/env bash

# Use this script to download and cleanup external blocklists.
# e.g.
# ./scripts/import.sh

# Download external blocklists
./scripts/download.sh < ./sources/_imported/README.md

# Cleanup sources
./scripts/cleanup.sh