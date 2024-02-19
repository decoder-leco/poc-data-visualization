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
    echo " >>>>>> OK INSTALL [DENO] COMPLETE "
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    echo " >>>>>> OK INSTALL [RUST +CARGO] COMPLETE "
RUN echo "export PATH=\"\$PATH:\$HOME/.cargo/bin\"" | tee -a ~/.shrc | tee -a ~/.bashrc && bash -c 'source "$HOME/.cargo/env"'
# >> reparations
# RUN apt-get install -y build-essential libssl-dev libffi-dev libzmq3-dev && apt-get install -y --fix-broken
RUN apt-get install -y build-essential libssl-dev libffi-dev libzmq3-dev
# RUN apt-get install -y python3-dev
RUN apt-get install -y libzmq3-dev musl-dev python3 python3-dev librust-zmq-dev
# >> J'ai clairement un problème de build de pyzmq : 
# >> probablement
RUN export PATH="$PATH:$HOME/.cargo/bin" && export PIP_DEFAULT_TIMEOUT=200 && python --version && python -m pip install pyzmq --trusted-host pypi.org --trusted-host files.pythonhosted.org

RUN export PATH="$PATH:$HOME/.cargo/bin" && export PIP_DEFAULT_TIMEOUT=200 && pip install jupyterlab notebook && \
    echo " >>>>>> OK INSTALL [pip install jupyterlab notebook] COMPLETE "
RUN deno jupyter --unstable --install && \
    echo " >>>>>> OK INSTALL [deno jupyter --unstable --install] COMPLETE "

RUN mkdir -p $DATAVIZ_NOTEBOOKS_HOME

FROM build as runner

RUN mkdir -p /run


COPY start.sh .
RUN chmod +x ./start.sh && mv ./start.sh /run

# CMD [ "jupyter", "notebook" ]

WORKDIR /usr/dataviz/notebooks/decoderleco
EXPOSE 8888
# CMD [ "jupyter", "notebook", "--unstable" ]
CMD [ "/run/start.sh" ]