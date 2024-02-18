#!/bin/bash
# --- 
# echo "test exec of [$0]"
# exit 0
# --- 
export NAME_OF_THE_MONGODB_DOCKER_VOLUME=${NAME_OF_THE_MONGODB_DOCKER_VOLUME:-"dataviz_poc_mongo_data"}
export SAMPLE_DATASET_GIT_REPO=${SAMPLE_DATASET_GIT_REPO:-"https://github.com/neelabalan/mongodb-sample-dataset.git"}

if [ "x${SAMPLE_DATASET_GIT_REPO}" == "x" ]; then
  echo "Error: The SAMPLE_DATASET_GIT_REPO env. var. is not set!"
  exit 3
fi;

if [ "x${NAME_OF_THE_MONGODB_DOCKER_VOLUME}" == "x" ]; then
  echo "Error: The NAME_OF_THE_MONGODB_DOCKER_VOLUME env. var. is not set!"
  exit 5
fi;

if [ -d ./mongo_init_datasets/ ]; then
  echo "WARN: The [$(pwd)/mongo_init_datasets/] folder already exists, we won't delete it. Stopping data samples retrieval process."
  exit 0
fi;

docker volume create --name ${NAME_OF_THE_MONGODB_DOCKER_VOLUME}

docker run -v ${NAME_OF_THE_MONGODB_DOCKER_VOLUME}:/data --name mongo_data_initializer busybox true

git clone ${SAMPLE_DATASET_GIT_REPO} ./mongo_init_datasets/
rm -fr ./mongo_init_datasets/.git/

echo "Sample datasets retried in [$(pwd)/mongo_init_datasets/]:"
ls -alh $(pwd)/mongo_init_datasets/

cd  ./mongo_init_datasets/

docker cp . $(pwd)/mongo_init_datasets:/data

cd ../

docker rm mongo_data_initializer