FROM gcr.io/static-cloud-builders/hugo

# NOTE: builder /workspace == container /

ARG builder_package_dir
ARG container_package_dir="/package"
ARG container_build_dir="/build"

COPY ["${builder_package_dir}", "${container_package_dir}"]

ARG site_dir
ARG site_config_file
ARG themes_dir
ARG theme_dir_name
ARG theme_config_file
ARG content_dir

# Validate hugo build run using preloaded test content at docker (image) build time
RUN set -e \
  \
  hugo \
  \
  --config ${container_package_dir}/${site_dir}/${site_config_file} \
  \
  --themesDir ${container_package_dir}/${themes_dir} \
  \
  --theme ${theme_dir_name} \
  \
  --contentDir ${container_package_dir}/${content_dir} \
  \
  --destination ${container_build_dir}
  
ENTRYPOINT ["hugo",
  "--config", "${container_package_dir}/${site_dir}/${site_config_file}",
  "--themesDir", "${container_package_dir}/${themes_dir}",
  "--theme", "${theme_dir_name}"]

# If cmd is not over written at docker run time, test content and local build folder will be used
# Easy to set these to /workspace/whatever/blah using CMD override
CMD ["--contentDir", "${container_package_dir}/${content_dir}", 
  "--destination", "${container_build_dir}"]
