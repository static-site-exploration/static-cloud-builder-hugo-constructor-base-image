#FROM gcr.io/static-cloud-builders/hugo

FROM busybox

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

RUN find /package

RUN set -e \
  \
  echo "Starting variable echo's:" \
  \
  && echo "hugo WORKDIR / " \
  \
  && echo "--config should be:" \
  && echo "/package/site/repo/exampleSite/config.toml" \
  && echo "${container_package_dir}/${site_dir}/${site_config_file}" \
  \
  && echo "--themesDir should be:" \
  && echo "/package/theme/repo/. (including repo sub folder)" \
  && echo "${container_package_dir}/${themes_dir}" \
  \
  && echo "--theme should be:" \
  && echo  "/." \
  && echo  ${theme_dir_name} \
  \
  && echo "--contentDir should be:" \
  && echo "/package/content/repo/exampleSite/content (including repo sub folder)" \
  && echo ${container_package_dir}/${content_dir} \
  \
  && echo "--destination should be:" \
  && echo "/build" \
  && echo  ${container_build_dir}
  
