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
apt-get install -y git git-flow
# --- about [libxrender1], see https://github.com/decoder-leco/poc-data-visualization/issues/9#issuecomment-1987203379
# --- about [libfontconfig1-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev], see https://github.com/decoder-leco/decoderleco_deces_europe_reloaded/pull/1#issuecomment-1987265383
apt-get install -y libxrender1 libfontconfig1-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev

python -m pip install jupyterlab-deck jupyterlab-git

R --version
Rscript --version

Rscript ./register.to.jupyter.r