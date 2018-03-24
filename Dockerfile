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
  \
  echo "Starting variable echo's:" \
  \
  && echo "should be: /package/site/repo/config.toml" \
  && echo ${container_package_dir}/${site_dir}/${config_file} \
  \
  && echo "should be: " \
  && echo ${container_package_dir}/${content_dir} \
  \
  && echo "should be: " \
  && echo  ${container_package_dir}/${themes_dir} \
  \
  && echo "should be: " \
  && echo  ${container_package_dir}/${themes_dir}/${theme_dir_name} \
  \
  && echo "should be: " \
  && echo  ${container_build_dir}
  
  
#CMD ${container_build_dir}

#RUN hugo \
#  --enableGitInfo \

#  --config ${container_package_dir}/${site_dir}/${config_file} \
#       /package/site/repo/config.toml

#  --contentDir ${container_package_dir}/${content_dir} \
#       /package/content/repo

#  --themesDir ${container_package_dir}/${themes_dir} \
#       /package/theme/repo

#  --theme ${container_package_dir}/${themes_dir}/${theme_dir_name} \
#       /package/theme/repo/.
#       /package/theme/repo/a-theme-name

#  --destination ${container_build_dir}
#       /build

