#!/bin/bash
set -e

echo -e '\n\033[1m[Preflight Checks]\033[0m'
echo -e "Docker client version: '$(docker version --format '{{.Client.Version}}')'"
echo -e "Docker server version: '$(docker version --format '{{.Server.Version}}')'"


echo -e '\n\033[1m[Build warmod:latest]\033[0m'
docker build . -f linux.Dockerfile --rm -t lacledeslan/gamesvr-csgo-warmod:latest --no-cache --pull --build-arg BUILDNODE=$(cat /proc/sys/kernel/hostname);
docker run -it --rm lacledeslan/gamesvr-csgo-warmod:latest ./ll-tests/gamesvr-csgo-warmod.sh

echo -e '\n\033[1m[Build warmod:hasty]\033[0m'
docker build . -f linux.Dockerfile --rm -t lacledeslan/gamesvr-csgo-warmod:hasty --no-cache --pull --build-arg BUILDNODE=$(cat /proc/sys/kernel/hostname);
docker run -it --rm lacledeslan/gamesvr-csgo-warmod:hasty ./ll-tests/gamesvr-csgo-warmod-hasty.sh

echo -e '\n\033[1m[Build warmod:overtime]\033[0m'
docker build . -f linux.Dockerfile --rm -t lacledeslan/gamesvr-csgo-warmod:overtime --no-cache --pull --build-arg BUILDNODE=$(cat /proc/sys/kernel/hostname);
docker run -it --rm lacledeslan/gamesvr-csgo-warmod:overtime ./ll-tests/gamesvr-csgo-warmod-overtime.sh


echo -e '\n\033[1m[Pushing to Docker Hub]\033[0m'
echo "> push lacledeslan/gamesvr-csgo-warmod:latest"
docker push lacledeslan/gamesvr-csgo-warmod:latest

echo "> push lacledeslan/gamesvr-csgo-warmod:hasty"
docker push lacledeslan/gamesvr-csgo-warmod:hasty

echo "> push lacledeslan/gamesvr-csgo-warmod:overtime"
docker push lacledeslan/gamesvr-csgo-warmod:overtime
