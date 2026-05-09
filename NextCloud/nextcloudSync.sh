#!/bin/bash
set -euo pipefail

WATCH_DIR="/mnt/porygonStorage/Nextcloud"

exec /usr/bin/nextcloudcmd "$WATCH_DIR" "$REMOTE"
