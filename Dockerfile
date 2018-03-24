FROM gcr.io/static-cloud-builders/hugo

# Directories are setup in the base image
ENV package_dir="/package"
ENV build_dir="/build"

ARG package_source=""
#COPY ${package_source} ${package_dir}
RUN ls -d .
