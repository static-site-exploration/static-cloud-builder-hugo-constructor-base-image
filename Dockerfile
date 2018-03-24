FROM gcr.io/static-cloud-builders/hugo
#FROM alpine

# builder /workspace == container /

ARG builder_package_dir
ARG container_package_dir="/package"

COPY ["$builder_package_dir", "$container_package_dir"]

#RUN echo ${builder_package_dir}
#RUN ls ${container_package_dir}

ARG site_config_file
ARG theme_config_file

ARG site_dir
ARG theme_dir
ARG content_dir

ENTRYPOINT [
  "hugo", 
  "--enableGitInfo", 
  "--config", "${container_package_dir}/${config_file}", 
  "--contentDir", "${container_package_dir}/${content_dir}", 
  "--themesDir", "${themes_dir}, 
  "--theme", "${theme_dir_name}, "--destination"
  ]
