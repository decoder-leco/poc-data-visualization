#!/bin/bash


if ! [ -d /data ]; then
  echo "Error: The /data folder does not exists!"
  exit 1
fi;

if [ "x${SAMPLE_DATASET_GIT_REPO}" == "x" ]; then
  echo "Error: The SAMPLE_DATASET_GIT_REPO env. var. is not set!"
  exit 3
fi;

git --version

git clone git@github.com:neelabalan/mongodb-sample-dataset.git /data && \
    rm -fr /data/.git/ && \
    echo "Datasets sucessfully imported."