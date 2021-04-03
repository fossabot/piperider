#!/bin/sh

path=${1:-.}
set -eux
isort --check-only ${path}
CODE=$((${CODE:-0} + ${?}))
black --check ${path}
CODE=$((${CODE:-0} + ${?}))
flake8 ${path}
CODE=$((${CODE:-0} + ${?}))
mypy ${path}
CODE=$((${CODE:-0} + ${?}))
exit ${CODE}
