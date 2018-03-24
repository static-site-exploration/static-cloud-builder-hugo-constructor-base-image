FROM gcr.io/static-cloud-builders/hugo

# Directories are setup in the base image
ENV container_package_dir="/package"
ENV container_dist_dir="/dist"

ARG builder_package_dir=""

WORKDIR ${builder_package_dir}
COPY . ${container_package_dir}

WORKDIR /

RUN test ${local_package_dir}/site
RUN test ${local_package_dir}/theme
RUN test ${local_package_dir}/content
