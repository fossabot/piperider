#!/bin/bash

mode=${1:-development}
DKR_REPOSITORY=${DKR_REPOSITORY:-piperider-dev-local}
DKR_TAG=${DKR_TAG:-latest}

usage() {
    cat << EOS
Usage: ./scripts/docker_build.sh [mode]

Args:
  mode: Build mode 'development' or 'production' (default: development).

Environment variables:
  DKR_REPOSITORY: Docker repository name (Set: ${DKR_REPOSITORY}).
  DKR_TAG       : Docker tag (Set: ${DKR_TAG}).
EOS
    exit 2
}

build_development() {
    set -eux
    docker build --force-rm --no-cache --rm --target=development \
        -t ${DKR_REPOSITORY}:${DKR_TAG} .
    [ "${DKR_TAG}" = "latest" ] && exit
    docker tag ${DKR_REPOSITORY}:${DKR_TAG} ${DKR_REPOSITORY}:latest
}

build_production() {
    set -eux
    docker build --force-rm --no-cache --rm \
        -t ${DKR_REPOSITORY}:${DKR_TAG} .
    [ "${DKR_TAG}" = "latest" ] && exit
    docker tag ${DKR_REPOSITORY}:${DKR_TAG} ${DKR_REPOSITORY}:latest
}

case "${mode}" in
    development)
        build_development
        ;;
    production)
        build_production
        ;;
    *)
        usage
        ;;
esac
