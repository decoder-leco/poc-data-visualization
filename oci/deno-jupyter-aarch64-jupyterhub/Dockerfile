# syntax = docker/dockerfile:1.3
# VULN_SCAN_TIME=2024-01-17_12:44:13


# The build stage
# ---------------
# This stage is building Python wheels for use in later stages by using a base
# image that has more pre-requisites to do so, such as a C++ compiler.
#
# NOTE: If the image version is updated, also update it in ci/refreeze and
#       hub's Dockerfile!
#
FROM python:3.11-bullseye as build-stage

# Build wheels
#
# We set pip's cache directory and expose it across build stages via an
# ephemeral docker cache (--mount=type=cache,target=${PIP_CACHE_DIR}). We use
# the same technique for the directory /tmp/wheels.
#
COPY requirements.txt requirements.txt
ARG PIP_CACHE_DIR=/tmp/pip-cache
RUN --mount=type=cache,target=${PIP_CACHE_DIR} \
    pip install build \
 && pip wheel \
        --wheel-dir=/tmp/wheels \
        -r requirements.txt


# The final stage
# ---------------
#
FROM python:3.11-slim-bullseye
ENV DEBIAN_FRONTEND=noninteractive

# ---
# About NB_GID: https://github.com/jupyter/docker-stacks/blob/996fae1248fcdd583a6a85be1f753d09acce9e25/images/docker-stacks-foundation/Dockerfile#L13
ARG NB_GID=100
ENV NB_GID=$NB_GID
ARG NB_USER=jovyan
ARG NB_UID=1000

ENV NB_USER=jovyan \
    NB_UID=$NB_UID \
    HOME=/home/jovyan
RUN adduser \
        --disabled-password \
        --gecos "Default user" \
        --uid ${NB_UID} \
        --home ${HOME} \
        --force-badname \
        ${NB_USER}

RUN apt-get update \
 && apt-get upgrade --yes \
 && apt-get install --yes --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        unzip \
        dnsutils \
        iputils-ping \
        tini \
        # requirement for nbgitpuller
        git \
 && rm -rf /var/lib/apt/lists/*

# install wheels built in the build-stage
COPY requirements.txt /tmp/requirements.txt
ARG PIP_CACHE_DIR=/tmp/pip-cache
RUN --mount=type=cache,target=${PIP_CACHE_DIR} \
    --mount=type=cache,from=build-stage,source=/tmp/wheels,target=/tmp/wheels \
    pip install \
        --find-links=/tmp/wheels/ \
        -r /tmp/requirements.txt


##########################################
##########################################
##### ADD DENO KERNEL: BEGINING
##########################################
##########################################

# > check jupyter installed version
RUN bash -c 'export PATH="$HOME/.local/bin:$PATH" && jupyter --version'

#################
# > Install deno
RUN curl -fsSL https://deno.land/install.sh | sh && \
    echo "DENO_INSTALL=[/home/${NB_USER}/.deno]" && \
    ls -alh /home/${NB_USER}/.deno && \
    ls -alh /home/${NB_USER}/.deno/bin && \
    ls -alh /home/${NB_USER}/.deno/bin/deno && \
    /home/${NB_USER}/.deno/bin/deno --version
RUN /home/${NB_USER}/.deno/bin/deno --version
RUN ${HOME}/.deno/bin/deno --version
RUN ~/.deno/bin/deno --version
RUN export DENO_INSTALL="/home/${NB_USER}/.deno" && export PATH="$DENO_INSTALL/bin:$PATH" && deno --version 
#################
# > Add env. var. for deno inside bashrc/shrc
RUN echo "export DENO_INSTALL='/home/${NB_USER}/.deno'" | tee -a ~/.bashrc | tee -a ~/.shrc && \
    echo 'export PATH="\$DENO_INSTALL/bin:$PATH"' | tee -a ~/.bashrc | tee -a ~/.shrc && \
    echo 'export PATH="\$HOME/.local/bin:$PATH"' | tee -a ~/.bashrc | tee -a ~/.shrc && \
    echo 'alias deno=~/.deno/bin/deno' | tee -a ~/.bashrc | tee -a ~/.shrc && \
    echo " >>>>>> OK INSTALL [DENO] COMPLETE "
#################
# > install deno jupyter kernel
RUN export DENO_INSTALL="/home/${NB_USER}/.deno" && \
    export PATH="$DENO_INSTALL/bin:$PATH" && \
    export PATH="$HOME/.local/bin:$PATH" && \
    deno jupyter --unstable --install && \
    echo " >>>>>> OK INSTALL [deno jupyter --unstable --install] COMPLETE "

##########################################
##########################################
##### ADD DENO KERNEL: END
##########################################
##########################################

# Copy a script that we will use to correct permissions after running certain commands
# Ref. : https://github.com/jupyter/docker-stacks/blob/996fae1248fcdd583a6a85be1f753d09acce9e25/images/docker-stacks-foundation/Dockerfile#L57
#        https://github.com/jupyter/docker-stacks/blob/996fae1248fcdd583a6a85be1f753d09acce9e25/images/docker-stacks-foundation/fix-permissions
COPY fix-permissions /usr/local/bin/fix-permissions
RUN chmod a+x /usr/local/bin/fix-permissions
RUN chown ${NB_USER}:${NB_USER} -R /home/${NB_USER} && \
    fix-permissions "/home/${NB_USER}"
# chmod: cannot access '/home/jovyan/.local/share/jupyter/runtime': No such file or directory
# RUN chmod a+x /home/${NB_USER}/.local/share/jupyter/runtime
USER ${NB_USER}
RUN fix-permissions "/home/${NB_USER}"
WORKDIR ${HOME}
USER ${NB_USER}

EXPOSE 8888
ENTRYPOINT ["tini", "--"]
CMD ["jupyter", "lab"]