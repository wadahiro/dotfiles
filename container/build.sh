#!/bin/sh

VERSION=ubuntu19.04

docker build -f Dockerfile.base . -t wadahiro/docker-guidev-base:$VERSION
docker build -f Dockerfile.base.ja . -t wadahiro/docker-guidev-base:${VERSION}_ja

docker build -f Dockerfile.i3wm --build-arg BASE_VERSION=$VERSION . -t wadahiro/docker-guidev-i3wm:$VERSION
docker build -f Dockerfile.i3wm --build-arg BASE_VERSION=${VERSION}_ja . -t wadahiro/docker-guidev-i3wm:${VERSION}_ja

docker build -f Dockerfile.lxde --build-arg BASE_VERSION=$VERSION . -t wadahiro/docker-guidev-lxde:$VERSION
docker build -f Dockerfile.lxde --build-arg BASE_VERSION=${VERSION}_ja . -t wadahiro/docker-guidev-lxde:${VERSION}_ja
