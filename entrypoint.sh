#!/usr/bin/env bash
set -e

/home/tresorit/tresorit-cli start
/home/tresorit/tresorit-cli drive --mount /home/tresorit/external
/home/tresorit/tresorit-cli status

exec "$@"
