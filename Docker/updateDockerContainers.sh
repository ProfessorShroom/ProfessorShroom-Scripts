#!/bin/sh

dockerDir="/path/to/docker/containers"

containers="
Jellyfin
Radarr
SABnzbd
Sonarr
"

for container in $containers; do
  echo "Updating $container..."
  cd "$dockerDir/$container" || exit 1
  docker compose pull
  docker compose up -d --remove-orphans --build --force-recreate
done
