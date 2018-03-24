#FROM gcr.io/static-cloud-builders/hugo
FROM alpine

# Directories are setup in the base image
ARG container_package_dir="/package"
ARG container_dist_dir="/dist"
ARG builder_package_dir=""

RUN ls

WORKDIR ${builder_package_dir}
COPY . ${container_package_dir}
