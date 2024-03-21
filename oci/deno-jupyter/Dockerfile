#
# On part d'une image python:3.10-slim pour créer l'image "build" 
#

## ARG BASE_IMAGE=denoland/deno:debian-1.40.5
# inspired by:
#  - https://blog.logrocket.com/deno-jupyter-notebook-data-dashboard/
#  - https://blog.jupyter.org/bringing-modern-javascript-to-the-jupyter-notebook-fc998095081e
#  - https://docs.deno.com/runtime/manual/tools/jupyter
#
# https://hub.docker.com/layers/library/python/3.13.0a4-slim-bookworm/images/sha256-225ac4a4b47349833efc94d61b93c8784279341aff99e714f6ca455ca9232509?context=explore
# ARG BASE_IMAGE=python:3.13.0a4-slim-bookworm
ARG BASE_IMAGE=python:3.10-slim

FROM $BASE_IMAGE as build

ARG BASE_IMAGE=$BASE_IMAGE

ARG DATAVIZ_NOTEBOOKS_HOME=/usr/dataviz/notebooks/decoderleco
ENV DATAVIZ_NOTEBOOKS_HOME=$DATAVIZ_NOTEBOOKS_HOME

#
# Installation d'utilitaires
#

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
    echo " >>>>>> OK INSTALL [DENO] COMPLETE "

#
# Installation Rust
#
    
RUN echo " >>>>>> start rust install" && curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    echo " >>>>>> OK INSTALL [RUST +CARGO] COMPLETE "
    
RUN echo "export PATH=\"\$PATH:\$HOME/.cargo/bin\"" | tee -a ~/.shrc | tee -a ~/.bashrc && bash -c 'source "$HOME/.cargo/env"'
RUN ls $HOME/.cargo/bin
RUN export PATH="$PATH:$HOME/.cargo/bin" && cargo --version
RUN apt-get install -y build-essential libssl-dev libffi-dev libzmq3-dev
# >> reparations
# RUN apt-get install -y build-essential libssl-dev libffi-dev libzmq3-dev && apt-get install -y --fix-broken
RUN apt-get install -y build-essential libssl-dev libffi-dev libzmq3-dev

# RUN export PATH="$PATH:$HOME/.cargo/bin" && export PIP_DEFAULT_TIMEOUT=200 && python --version && python -m pip install pyzmq --trusted-host pypi.org --trusted-host files.pythonhosted.org

#
# Installation Pip
#

WORKDIR /app

COPY requirements.txt /app

# RUN pip install -r requirements.txt
RUN python -m pip install --upgrade pip

RUN export PATH="$PATH:$HOME/.cargo/bin" && export PIP_DEFAULT_TIMEOUT=200 && pip install -r requirements.txt

#
# Installation Jupyter Notebook
#

RUN export PATH="$PATH:$HOME/.cargo/bin" && export PIP_DEFAULT_TIMEOUT=200 && pip install jupyterlab notebook && \
    echo " >>>>>> OK INSTALL [pip install jupyterlab notebook] COMPLETE "

#
# Installation Deno
#

    
RUN curl -fsSL https://deno.land/install.sh | sh && \
    echo 'export DENO_INSTALL="/root/.deno"' | tee -a ~/.bashrc | tee -a ~/.shrc && \
    echo 'export PATH="$DENO_INSTALL/bin:$PATH"' | tee -a ~/.bashrc | tee -a ~/.shrc && \
    echo " >>>>>> OK INSTALL [DENO] COMPLETE "

RUN bash -c 'source ~/.bashrc && deno jupyter --unstable --install' && \
    echo " >>>>>> OK INSTALL [deno jupyter --unstable --install] COMPLETE "

RUN mkdir -p $DATAVIZ_NOTEBOOKS_HOME



#########################################################################################################

#
# On part de l'image "build" pour créer l'image "deno_runner" 
#

FROM build as deno_runner

RUN mkdir -p /run

COPY start.sh .
RUN chmod +x ./start.sh && mv ./start.sh /run

COPY start.debug.sh .
RUN chmod +x ./start.debug.sh && mv ./start.debug.sh /run


WORKDIR /usr/dataviz/notebooks/decoderleco
EXPOSE 8888

# CMD [ "/run/start.sh" ]
CMD [ "/run/start.debug.sh" ]


#########################################################################################################

#
# On part de l'image "deno_runner" pour créer l'image "add_r_kernel" 
#

FROM deno_runner as add_r_kernel

RUN mkdir -p /kernels/extras/ && mkdir -p /kernels/ops/ 

WORKDIR /kernels/ops/

COPY add-rlang-kernel.sh .
RUN chmod +x ./add-rlang-kernel.sh && ./add-rlang-kernel.sh

RUN bash -c 'echo "in docker build, check conda install:" && source ~/.bashrc && conda --version && Rscript --version && R --version'

COPY ./register.r.ikernel.sh .
RUN chmod +x ./register.r.ikernel.sh && ./register.r.ikernel.sh

WORKDIR /usr/dataviz/notebooks/decoderleco
