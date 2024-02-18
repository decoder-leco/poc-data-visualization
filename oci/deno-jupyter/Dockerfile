## ARG BASE_IMAGE=denoland/deno:debian-1.40.5
# inspired by:
#  - https://blog.logrocket.com/deno-jupyter-notebook-data-dashboard/
#  - https://blog.jupyter.org/bringing-modern-javascript-to-the-jupyter-notebook-fc998095081e
#  - https://docs.deno.com/runtime/manual/tools/jupyter
# 
# https://hub.docker.com/layers/library/python/3.13.0a4-slim-bookworm/images/sha256-225ac4a4b47349833efc94d61b93c8784279341aff99e714f6ca455ca9232509?context=explore
ARG BASE_IMAGE=python:3.13.0a4-slim-bookworm

FROM $BASE_IMAGE as build

ARG BASE_IMAGE=$BASE_IMAGE
ARG DATAVIZ_NOTEBOOKS_HOME=/usr/dataviz/notebooks/decoderleco
ENV DATAVIZ_NOTEBOOKS_HOME=$DATAVIZ_NOTEBOOKS_HOME

RUN apt-get update -y && \
    echo " >>>>>> OK UPDATE COMPLETE " && \
    apt-get install -y curl && \
    echo " >>>>>> OK INSTALL [curl] COMPLETE " && \
    apt-get install -y jq && \
    echo " >>>>>> OK INSTALL [jq] COMPLETE " && \
    apt-get install -y build-essential && \
    echo " >>>>>> OK INSTALL [build-essential] COMPLETE " && \
    apt-get install -y unzip && \
    echo " >>>>>> OK INSTALL [unzip] COMPLETE " && \
    curl -fsSL https://deno.land/install.sh | sh && \
    echo " >>>>>> OK INSTALL [DENO] COMPLETE " && \
    pip install jupyterlab notebook && \
    echo " >>>>>> OK INSTALL [pip install jupyterlab notebook] COMPLETE " && \
    deno jupyter --unstable --install && \
    echo " >>>>>> OK INSTALL [deno jupyter --unstable --install] COMPLETE "

RUN mkdir -p $DATAVIZ_NOTEBOOKS_HOME

FROM build as runner

WORKDIR /usr/dataviz/notebooks/decoderleco

EXPOSE 8888

# CMD [ "jupyter", "notebook" ]

CMD [ "jupyter", "notebook", "--unstable" ]