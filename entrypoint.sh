#!/bin/bash
set -e

SYNC_ONLY=${SYNC_ONLY:-false}

echo "Starting tresorit cli…"
tresorit-cli start
tresorit-cli status

echo "Disabling logging…"
tresorit-cli logging --disable-log-sending
tresorit-cli logging --disable-metrics
tresorit-cli logging --status

if [ "$SYNC_ONLY" = false ] && [ -f "/home/tresorit/Profiles/global.profile" ]; then

  # mount drive
  tresorit-cli drive --mount /home/tresorit/drive

  echo "" > /tmp/cron

  # add custom crontabs
  for var in "${!CRONTAB_@}"; do
    echo "${!var}" >> /tmp/cron
  done

  crontab /tmp/cron

fi

exec "$@"
