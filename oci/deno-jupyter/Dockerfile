## ARG BASE_IMAGE=denoland/deno:debian-1.40.5
# inspired by https://blog.logrocket.com/deno-jupyter-notebook-data-dashboard/
# https://hub.docker.com/layers/library/python/3.13.0a4-slim-bookworm/images/sha256-225ac4a4b47349833efc94d61b93c8784279341aff99e714f6ca455ca9232509?context=explore
ARG BASE_IMAGE=python:3.13.0a4-slim-bookworm

FROM $BASE_IMAGE as build

ARG BASE_IMAGE=$BASE_IMAGE
ARG DATAVIZ_NOTEBOOKS_HOME=/usr/dataviz/notebooks/decoderleco
ENV DATAVIZ_NOTEBOOKS_HOME=$DATAVIZ_NOTEBOOKS_HOME

RUN apt-get update -y && \
    apt-get install -y curl build-essential jq && \
    curl -fsSL https://deno.land/install.sh | sh && \
    pip install jupyterlab notebook && \
    deno jupyter --unstable --install

RUN mkdir -p $DATAVIZ_NOTEBOOKS_HOME


FROM build as runner

WORKDIR /usr/dataviz/notebooks/decoderleco

EXPOSE 8888

# CMD [ "jupyter", "notebook" ]

CMD [ "jupyter", "notebook", "--unstable" ]