#!/bin/bash -e

VERSION=ubuntu19.04
IMAGE_PREFIX=wadahiro/desktop

# Base
docker build -f Dockerfile.base . -t ${IMAGE_PREFIX}-base:$VERSION


# Window Manager
WINDOW_MANAGERS=(regolith lxde)
LANGUAGES=(ja)
for WM in ${WINDOW_MANAGERS[@]}; do
    docker build -f Dockerfile.${WM} --build-arg BASE_IMAGE=${IMAGE_PREFIX}-base:${VERSION} . -t ${IMAGE_PREFIX}-${WM}:${VERSION}

    docker build -f Dockerfile.tool --build-arg BASE_IMAGE=${IMAGE_PREFIX}-${WM}:${VERSION} . -t ${IMAGE_PREFIX}-${WM}:${VERSION}_tool

    # Language
    for LANGUAGE in ${LANGUAGES[@]}; do
	echo $LANGUAGE
        docker build -f Dockerfile.${LANGUAGE} --build-arg BASE_IMAGE=${IMAGE_PREFIX}-${WM}:${VERSION}_tool . -t ${IMAGE_PREFIX}-${WM}:${VERSION}_${LANGUAGE}
    done
done

