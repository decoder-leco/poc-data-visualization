#!/bin/bash

source ~/.bashrc

# see https://irkernel.github.io/installation/

echo 'options(repos = c(CRAN = "https://cloud.r-project.org"))' > ~/.Rprofile

cat <<EOF >./register.to.jupyter.r
install.packages('IRkernel')
# + The kernel spec can be installed for the current user with the following line from R:
# IRkernel::installspec()
# + To install system-wide, set user to False in the installspec command:
IRkernel::installspec(user = FALSE)
EOF
# ----
# - unfortunately, it seems the @techrah/text-shortcuts extension is no longer available
# jupyter labextension install @techrah/text-shortcuts
# source ~/.bashrc && conda install -y -c conda-forge @techrah/text-shortcuts
# conda install -y -c conda-forge @techrah/text-shortcuts
# ---

# --- 
# the symlink so that anaconda thinks its him who installed jupyter...?
# ln -s /usr/local/bin/jupyter ${HOME}/anaconda3/bin/jupyter
# But we want sweeties, so...:
# https://github.com/deathbeds/jupyterlab-deck
# conda install -y -c conda-forge jupyterlab-deck # even with the above symlink, i don't think that any conda install command would change anything to the jupyter lab

# ----- 
# --- just like [r-notebook] docker image

# ---
# - first uninstall conda packages previously installed:
# conda install -y -c r r-irkernel
# CONDA HELP: Use `--all` flag to remove all packages and the environment itself.
# conda remove -y -f --all

# export DESIRED_CONDA_R_BASE_VERSION=${DESIRED_CONDA_R_BASE_VERSION:-"4.3.3"}
# 4.3.1 is latest available version in the 'r' conda channel, according https://anaconda.org/search?q=r-base
export DESIRED_CONDA_R_BASE_VERSION=${DESIRED_CONDA_R_BASE_VERSION:-"4.3.1"} # installing 4.3.1 version, i still ended up with a 4.2.2 version of R ....


# conda install --yes -f -c conda-forge \
conda install --yes \
    "r-base=${DESIRED_CONDA_R_BASE_VERSION}" \
    'r-caret' \
    'r-crayon' \
    'r-devtools' \
    'r-e1071' \
    'r-forecast' \
    'r-hexbin' \
    'r-htmltools' \
    'r-htmlwidgets' \
    'r-irkernel' \
    'r-nycflights13' \
    'r-randomforest' \
    'r-rcurl' \
    'r-rmarkdown' \
    'r-rodbc' \
    'r-rsqlite' \
    'r-shiny' \
    'r-tidymodels' \
    'r-tidyverse' \
    'unixodbc' && \
    conda clean --all -f -y && \
    conda update --all -y

#    mamba clean --all -f -y && \
#    fix-permissions "${CONDA_DIR}" && \
#    fix-permissions "/home/${NB_USER}
# ---
# -----

python -m pip install jupyterlab-deck jupyterlab-git

R --version
Rscript --version

Rscript ./register.to.jupyter.r