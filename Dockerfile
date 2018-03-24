FROM gcr.io/static-cloud-builders/hugo

ARG site_source="/workspace/package" # default
ADD ["${site_source}", "/site"]

ARG base_dir"/site" # default
ARG config_file="$base_dir/config.toml" # default
ARG content_dir="$base_dir/" # default
ARG themes_dir="$base_dir/themes" # default
ARG destination_dir="$base_dir/dist" # default

ENTRYPOINT ["hugo"]
# CMD can be overriden, using the following as defaults, all must be provided
CMD ["--config", "${config_file}", "--contentDir", "${content_dir}", "--themesDir", "${themes_dir}", --destination", "${destination_dir}", "--enableGitInfo"]
