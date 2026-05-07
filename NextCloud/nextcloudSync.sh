#!/bin/bash
set -euo pipefail

WATCH_DIR="/path/to/Nextcloud"
REMOTE="https://username:password@nextclouddomain.com"

exec /usr/bin/nextcloudcmd "$WATCH_DIR" "$REMOTE"
