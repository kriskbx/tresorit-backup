#!/usr/bin/env bash

for d in /home/tresorit/drive/*/ ; do
	BASENAME=$(basename "$d")
    echo "Starting sync of $BASENAME…"
    rsync -arz --progress "$d" "/home/tresorit/external/$BASENAME"
done
