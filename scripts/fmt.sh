#!/bin/sh

path=${1:-.}
set -eux
isort ${path}
black ${path}
