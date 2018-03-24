FROM gcr.io/static-cloud-builders/hugo

# Default argument set:
ARG package_source="/workspace/package"

# Special folder was created within hugo base image
ADD ["${package_source}", "/package"]

ENV base_dir="/build" 
ARG config_file="$base_dir/config.toml"
ARG content_dir="$base_dir/content"
ARG themes_dir="$base_dir/themes"
ARG theme_name=""

# special folder was created within hugo base image
ARG destination_dir="/build" 

ENTRYPOINT ["hugo", "--enableGitInfo", "--config", "${config_file}", "--contentDir", "${content_dir}", "--themesDir", "${themes_dir}, "--destination"]

# If being run by a GCR build process, this can be set to a shared volume, seperate to the other options but will default if not set
CMD ["${destination_dir}"]
