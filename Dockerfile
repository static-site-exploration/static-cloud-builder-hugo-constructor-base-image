#FROM gcr.io/static-cloud-builders/hugo
FROM alpine

# builder /workspace == container /

ARG builder_package_dir=""
#ARG builder_package_dir="/package"

ARG builder_package_dir="./package"
ARG container_package_dir="/build"

COPY ["${container_package_dir}", "${container_package_dir}"]
RUN ["ls", "${container_package_dir}"]
