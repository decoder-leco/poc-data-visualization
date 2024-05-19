#!/bin/bash

export PATH="$PATH:$HOME/.cargo/bin"
export DENO_INSTALL="/home/${NB_USER}/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:$HOME/anaconda3/bin

# source ~/.bashrc

echo "# --- # --- # --- # --- # --- # --- "
echo "# --- # --- # --- # --- # --- # --- "
echo "# --- Cheking executables"
ls -alh /home/${NB_USER}/.deno/bin/deno
/home/${NB_USER}/.deno/bin/deno --version
ls -alh $HOME/anaconda3/bin/conda
$HOME/anaconda3/bin/conda --version
ls -alh /home/${NB_USER}/.cargo/bin/cargo
/home/${NB_USER}/.cargo/bin/cargo --version

alias cargo="/home/${NB_USER}/.cargo/bin/cargo"
alias conda="$HOME/anaconda3/bin/conda"
alias deno="/home/${NB_USER}/.deno/bin/deno"

echo "# --- # --- # --- # --- # --- # --- "
echo "# --- # --- # --- # --- # --- # --- "
pwd

cargo --version


deno --version
# KO # deno jupyter --install --unstable-ffi --allow-ffi --allow-env
# KO # deno jupyter --install --unstable-ffi --allow-env
# OK but does not fix [ffi dl open] error # deno jupyter --install --unstable-ffi --unstable --unstable-fs --unstable-worker-options
deno jupyter --install --unstable-ffi --unstable-fs # without [--unstable] which is deprecated for [--unstable-*] options
# deno jupyter --install --unstable-ffi

# tested works # jupyter notebook --unstable true --ip 0.0.0.0 --allow-root
# export NOTEBOOKS_DIR=$DATAVIZ_NOTEBOOKS_HOME
# -->> NOTEBOOKS_DIR must match Helm Chart's
#      singleuser-storage-homemountpath
#      https://z2jh.jupyter.org/en/stable/resources/reference.html#singleuser-storage-homemountpath
export NOTEBOOKS_DIR=${HOME}/workspace
mkdir -p ${NOTEBOOKS_DIR}

# OK # jupyter lab --unstable=true --ip=0.0.0.0 --allow-root --NotebookApp.token='decoderleco' --NotebookApp.password='decoderleco' --notebook-dir="$NOTEBOOKS_DIR"
# KO # jupyter-lab: error: unrecognized arguments: --unstable-ffi=true --unstable-fs=true # jupyter lab --unstable=true --unstable-ffi=true --unstable-fs=true --ip=0.0.0.0 --allow-root --NotebookApp.token='decoderleco' --NotebookApp.password='decoderleco' --notebook-dir="$NOTEBOOKS_DIR"
# KO # jupyter-lab: error: unrecognized arguments: --unstable-ffi --unstable-fs # jupyter lab --unstable=true --unstable-ffi --unstable-fs --ip=0.0.0.0 --allow-root --NotebookApp.token='decoderleco' --NotebookApp.password='decoderleco' --notebook-dir="$NOTEBOOKS_DIR"
# jupyter lab --unstable=true --ip=0.0.0.0 --allow-root --NotebookApp.token='decoderleco' --NotebookApp.password='decoderleco' --notebook-dir="$NOTEBOOKS_DIR"

# jupyter lab --unstable=true --ip=0.0.0.0 --allow-root --NotebookApp.token='decoderleco' --NotebookApp.password='decoderleco'
# KO # jupyter lab --unstable=true --ip=0.0.0.0 --NotebookApp.base_url="${JUPYTERHUB_SERVICE_PREFIX}"
# --> [ --NotebookApp.token='' --NotebookApp.password=''] disables authentication
jupyter lab --unstable=true --ip=0.0.0.0 --NotebookApp.base_url="${JUPYTERHUB_SERVICE_PREFIX}" --NotebookApp.token='' --NotebookApp.password='' --notebook-dir="$NOTEBOOKS_DIR"
# jupyter lab --unstable=true --ip=0.0.0.0




