#!/usr/bin/env bash
set -e

/home/tresorit/tresorit-cli start
/home/tresorit/tresorit-cli status

exec "$@"
