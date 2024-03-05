# `MongoDB` init

In this folder, all `MongoDB` database initalization resources.

## How to add data into the MongoDB named volume

```bash
export NAME_OF_THE_MONGODB_DOCKER_VOLUME=${NAME_OF_THE_MONGODB_DOCKER_VOLUME:-"dataviz_poc_mongo_data"}

docker run -v ${NAME_OF_THE_MONGODB_DOCKER_VOLUME}:/data --name mongo_data_initializer busybox true

git clone git@github.com:neelabalan/mongodb-sample-dataset.git ./mongo_init_datasets/
rm -fr ./mongo_init_datasets/.git/
cd  ./mongo_init_datasets/
docker cp . mongo_data_initializer:/data
cd ../
docker rm mongo_data_initializer
```
