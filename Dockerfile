FROM gcr.io/static-cloud-builders/hugo

ARG site_source="/workspace/package" # default
ADD ["${package_source}", "/build"]

ENV base_dir="/build" # default
ARG config_file="$base_dir/config.toml" # default
ARG content_dir="$base_dir/content" # default
ARG themes_dir="$base_dir/themes" # default
ARG theme_name=""

ARG destination_dir="$base_dir/dist" # default

ENTRYPOINT ["hugo", "--enableGitInfo", "--config", "${config_file}", "--contentDir", "${content_dir}", "--themesDir", "${themes_dir}, "--destination"]

# If being run by a GCR build process, this can be set to a shared volume, seperate to the other options but will default if not set
CMD ["${destination_dir}"]
