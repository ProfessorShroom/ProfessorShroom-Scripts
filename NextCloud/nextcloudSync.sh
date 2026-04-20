#!/bin/bash
#
# Unified Nextcloud sync script (quiet version)
# - Watches local folder for changes (via inotifywait)
# - Runs full sync every 10 minutes
# - Uses lockfile so only one sync runs at a time
# - Logs only errors, into /tmp (cleared on reboot)

WATCH_DIR="/path/to/Nextcloud"
REMOTE="https://username:password@nextclouddomain.com"
LOCKFILE="/tmp/nextcloudsync.lock"
BACKUPLOCKFILE="/tmp/backupnextcloudsync.lock"

# Function: run sync safely
run_sync() {
    # Check if backup lockfile exists (presence only)
    if [ -e "$BACKUPLOCKFILE" ]; then
        return
    fi

    # Check if our own lockfile is active (PID-based)
    if [ -e "$LOCKFILE" ] && kill -0 $(cat "$LOCKFILE") 2>/dev/null; then
        return
    fi

    # Create our PID-based lockfile
    echo $$ > "$LOCKFILE"

    # Run nextcloudcmd, discard stdout, timestamp stderr into log
    nextcloudcmd "$WATCH_DIR" "$REMOTE" > /dev/null 2> >(
        while IFS= read -r line; do
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] $line" >> /dev/null
        done
    )

    rm -f "$LOCKFILE"
}

# Background: periodic sync every 10 minutes
(
  while true; do
    run_sync
    sleep 600   # 600 seconds = 10 minutes
  done
) &

# Foreground: watch local changes
/usr/bin/inotifywait -m -r -e modify,create,delete "$WATCH_DIR" --format '%w%f' |
while read -r FILE; do
    run_sync
done
