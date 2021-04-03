##################################################
# Local development environment.
##################################################
FROM python:3.8-slim

ENV PYTHONDONTWRITEBYTECODE=1

WORKDIR /opt/work

COPY poetry.lock .
COPY pyproject.toml .

RUN set -eux \
 && apt-get update -yqq \
 && apt-get upgrade -yqq \
 && pip install -U pip setuptools poetry \
 && poetry config virtualenvs.create false \
 && poetry install --no-root \
 && apt-get autoremove -yqq --purge \
 && apt-get -y clean \
 && rm -rf \
        /tmp/* \
        /usr/share/doc \
        /usr/share/doc-base \
        /usr/share/man \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        poetry.lock \
        pyproject.toml
