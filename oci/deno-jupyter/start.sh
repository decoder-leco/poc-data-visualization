#!/bin/bash

export PATH="$PATH:$HOME/.cargo/bin"
source ~/.bashrc

pwd

cargo --version


deno --version
deno jupyter --install --unstable-ffi




# tested works # jupyter notebook --unstable true --ip 0.0.0.0 --allow-root
export NOTEBOOKS_DIR=$DATAVIZ_NOTEBOOKS_HOME
jupyter lab --unstable=true --ip=0.0.0.0 --allow-root --NotebookApp.token='decoderleco' --NotebookApp.password='decoderleco' --notebook-dir="$NOTEBOOKS_DIR"
