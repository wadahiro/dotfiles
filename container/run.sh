#!/bin/sh

USER=$1
PASSWD=$2

docker run --rm -it \
  -p 3389:3389 \
  --privileged \
  -v /run/dbus:/run/dbus \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --shm-size=1g \
  -v $HOME/dotfiles:/home/$USER \
  -u $(id -u):$(id -g) \
  -e USER=$USER -e PASSWD=$PASSWD \
  wadahiro/desktop-regolith:ubuntu19.04_ja_tool
