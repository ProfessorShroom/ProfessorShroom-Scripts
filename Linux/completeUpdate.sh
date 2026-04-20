#!/bin/sh

echo "Updating Ubuntu..."
sudo apt update && sudo apt upgrade -y
echo "Updating Docker Containers..."
/mnt/porygonStorage/Storage/Scripts/Docker/updateDockerContainers.sh
echo "Pruning Old Docker Containers..."
docker image prune -a -f
