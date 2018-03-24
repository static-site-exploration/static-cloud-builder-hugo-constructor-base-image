#FROM gcr.io/static-cloud-builders/hugo
FROM alpine

# Directories are setup in the base image
ARG container_package_dir="/localspace/package"
ARG container_dist_dir="/localspace/dist"
ARG builder_package_dir=""

RUN mkdir -p ${container_package_dir}
RUN mkdir -p ${container_dist_dir}

RUN ls

WORKDIR ${builder_package_dir}
COPY . ${container_package_dir}

WORKDIR /localspace

RUN ls
