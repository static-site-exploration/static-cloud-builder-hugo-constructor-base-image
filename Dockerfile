FROM busybox

COPY ["/build.sh", "."]
RUN  ["chmod", "+x", "build.sh"]

FROM gcr.io/static-cloud-builders/hugo

# NOTE: builder /workspace == container / && container default WORKDIR == ./ 

COPY --from=0 build.sh .

ARG builder_package_dir
ENV container_package_dir="/package"
ENV container_build_dir="/build"

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

# !! NEED TO SET THESE ENTRYPOINT VARIABLE VALUES (something like eval) AT BUILD TIME !!

# Make selected argument values available at RUN time
ENV site_dir=${site_dir}
ENV site_config_file=${site_config_file}
ENV themes_dir=${themes_dir}
ENV theme_dir_name=${theme_dir_name}
ENV content_dir=${content_dir}

# Test the script at build time
RUN ["build.sh"]
RUN ["sh", "build.sh", "a_test_argument_from_exec_AT_BUILD_TIME"]

#ENTRYPOINT ["sh", "-c", "build.sh"]
ENTRYPOINT ["build.sh"]
# If cmd is not over written at docker run time, test content and local build folder will be used
# Easy to set these to /workspace/whatever/blah using CMD override
