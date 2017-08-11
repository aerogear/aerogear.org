#!/bin/bash
cd ..
HOST_GIT_REPO_DIR=${PWD}
IMG_GIT_REPO_DIR="/home/aerogear/aerogear"
DOCKER_OPT="--privileged -ti --rm -p 4000:4000"

docker run $DOCKER_OPT -v $HOST_GIT_REPO_DIR:$IMG_GIT_REPO_DIR  aerogear.org

