FROM gcr.io/static-cloud-builders/hugo

# Directories are setup in the base image
# Abslolute paths
ENV package_dir="/package"
ENV build_dir="/build"

# Default arguments that can be overriden at RUNTIME:
# Ensure these are relative paths
ARG package_source=""
ARG content_dir=""
ARG themes_dir=""
ARG site_config_file=""
ARG theme_dir_name=""

# Special folder was created within hugo base image
ADD ["${package_source}", "/package"]

WORKDIR ${package_dir}
ENTRYPOINT ["hugo", "--enableGitInfo", "--config", "${config_file}", "--contentDir", "${content_dir}", "--themesDir", "${themes_dir}, "--theme", "${theme_dir_name}, "--destination"]

# If being run by a GCR build process, this can be set to a shared volume, seperate to the other options but will default if not set
CMD ["${build_dir}"]
