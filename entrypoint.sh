#!/bin/sh
set -e

BACKUP_SCRIPT=/usr/local/bin/tresorit-backup.sh

SYNC_ONLY=${SYNC_ONLY:-false}
SCHEDULE=${SCHEDULE:-"0 3 * * *"}

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

    # add backup script to crontab
    echo "$SCHEDULE $BACKUP_SCRIPT" | crontab -

    # run backup script once at startup
    sh $BACKUP_SCRIPT

fi

exec "$@"
