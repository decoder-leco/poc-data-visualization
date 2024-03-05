# FROM alpine:3.5
ARG BASE_IMAGE=debian:bookworm-20240211-slim

FROM $BASE_IMAGE as base

ARG BASE_IMAGE=$BASE_IMAGE
RUN apt-get update -y && \
    echo " >>>>>> OK UPDATE COMPLETE " && \
    apt-get install -y git && \
    echo " >>>>>> OK INSTALL [git] COMPLETE "

FROM base as initializer

ARG NAME_OF_THE_MONGODB_DOCKER_VOLUME="dataviz_poc_mongo_data"
ENV NAME_OF_THE_MONGODB_DOCKER_VOLUME=$NAME_OF_THE_MONGODB_DOCKER_VOLUME

# ARG SAMPLE_DATASET_GIT_REPO=git@github.com:neelabalan/mongodb-sample-dataset.git
ARG SAMPLE_DATASET_GIT_REPO=https://github.com/neelabalan/mongodb-sample-dataset.git
ENV SAMPLE_DATASET_GIT_REPO=$SAMPLE_DATASET_GIT_REPO

RUN mkdir /data && /initializer/samples
COPY getsamples.sh /initializer/samples
RUN chmod +x /initializer/samples/getsamples.sh

VOLUME /data
WORKDIR /data
# docker run -v ${NAME_OF_THE_MONGODB_DOCKER_VOLUME}:/data --name mongo_data_initializer busybox true

# RUN git clone git@github.com:neelabalan/mongodb-sample-dataset.git ./mongo_init_datasets/

CMD [ "/initializer/samples/run.sh" ]