#FROM gcr.io/static-cloud-builders/hugo

FROM alpine
RUN mkdir -p /package
RUN mkdir -p /build
RUN mkdir -p /dist

# builder /workspace == container /

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

RUN echo ${builder_package_dir}
RUN ls ${container_package_dir}

RUN set -e \
  echo ${container_package_dir}/${site_dir}/${config_file} \
  && echo ${container_package_dir}/${content_dir} \
  && echo  ${container_package_dir}/${themes_dir} \
  && echo  ${container_package_dir}/${themes_dir}/${theme_dir_name} \
  && echo  ${container_build_dir}

#CMD ${container_build_dir}
