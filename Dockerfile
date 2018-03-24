FROM gcr.io/static-cloud-builders/hugo
#FROM alpine

# builder /workspace == container /

ARG builder_package_dir
ARG container_package_dir="/package"

COPY ["${builder_package_dir}", "${container_package_dir}"]

#RUN echo ${builder_package_dir}
#RUN ls ${container_package_dir}

ARG site_config_file
ARG theme_config_file

ARG site_dir
ARG themes_dir
ARG content_dir

ARG theme_dir_name

ARG container_build_dir="/build"
#RUN mkdir ${container_build_dir}

RUN hugo --help

RUN hugo \
  --enableGitInfo \
  --config ${container_package_dir}/${config_file} \
  --contentDir ${container_package_dir}/${content_dir} \
  --themesDir ${container_package_dir}/${themes_dir} \
  --theme ${container_package_dir}/${themes_dir}/${theme_dir_name} 
  --destination ${container_build_dir}

#CMD ${container_build_dir}
