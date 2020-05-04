#!/usr/bin/env bash

for d in /home/tresorit/drive/*/ ; do
    echo "Starting sync of $(basename $d)…"
    rsync -arz --progress "$d" "/home/tresorit/external/$(basename $d)"
done
