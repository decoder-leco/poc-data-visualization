#!/bin/bash

export PATH="$PATH:$HOME/.cargo/bin"
source ~/.bashrc

pwd

cargo --version


deno --version
# KO # deno jupyter --install --unstable-ffi --allow-ffi --allow-env
# KO # deno jupyter --install --unstable-ffi --allow-env
# OK but does not fix [ffi dl open] error # deno jupyter --install --unstable-ffi --unstable --unstable-fs --unstable-worker-options
deno jupyter --install --unstable-ffi --unstable-fs # without [--unstable] which is deprecated for [--unstable-*] options
# deno jupyter --install --unstable-ffi

# tested works # jupyter notebook --unstable true --ip 0.0.0.0 --allow-root
export NOTEBOOKS_DIR=$DATAVIZ_NOTEBOOKS_HOME
# OK # jupyter lab --unstable=true --ip=0.0.0.0 --allow-root --NotebookApp.token='decoderleco' --NotebookApp.password='decoderleco' --notebook-dir="$NOTEBOOKS_DIR"
# KO # jupyter-lab: error: unrecognized arguments: --unstable-ffi=true --unstable-fs=true # jupyter lab --unstable=true --unstable-ffi=true --unstable-fs=true --ip=0.0.0.0 --allow-root --NotebookApp.token='decoderleco' --NotebookApp.password='decoderleco' --notebook-dir="$NOTEBOOKS_DIR"
jupyter lab --unstable=true --unstable-ffi --unstable-fs --ip=0.0.0.0 --allow-root --NotebookApp.token='decoderleco' --NotebookApp.password='decoderleco' --notebook-dir="$NOTEBOOKS_DIR"
