#/bin/bash
# Linux packages required to install [jupyterlab-deck jupyterlab-git] Jupyter lab extensions
apt-get install -y git git-flow
# Linux packages required to install R IKernel
apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    fonts-dejavu \
    unixodbc \
    unixodbc-dev \
    r-cran-rodbc \
    gfortran \
    gcc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# --- ajout jb, pour debug résolution dépendances decoderleco:
apt-get install --yes \
  libcurl4-openssl-dev \
  libudunits2-dev \
  libfreetype6-dev \
  libpng-dev \
  libtiff5-dev \
  libharfbuzz-dev \
  libfribidi-dev \
  libfontconfig1-dev \
  libgdal-dev

# libgdal-dev # to be able to install [gdal] R package 

# --- about [libxrender1], see https://github.com/decoder-leco/poc-data-visualization/issues/9#issuecomment-1987203379
# --- about [libfontconfig1-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev], see https://github.com/decoder-leco/decoderleco_deces_europe_reloaded/pull/1#issuecomment-1987265383
# apt-get install -y libxrender1 libfontconfig1-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev
