#!/bin/sh

VERSION=ubuntu19.04_ja

docker build -f Dockerfile.base . -t wadahiro/docker-guidev-base:$VERSION
docker build -f Dockerfile.i3wm --build-arg BASE_VERSION=$VERSION . -t wadahiro/docker-guidev-i3wm:$VERSION
