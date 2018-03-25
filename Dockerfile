#FROM gcr.io/static-cloud-builders/hugo

FROM alpine
RUN apk add -u findutils

RUN mkdir -p /package
RUN mkdir -p /build
RUN mkdir -p /dist

# NOTE: builder /workspace == container /

ARG builder_package_dir
ARG container_package_dir="/package"

COPY ["${builder_package_dir}", "${container_package_dir}"]

ARG site_dir
ARG site_config_file
ARG themes_dir
ARG theme_dir_name
ARG theme_config_file
ARG content_dir

ARG container_build_dir="/build"

RUN find /package -type -d

