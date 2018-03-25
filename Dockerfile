FROM busybox

COPY ["/build.sh", "/"]
RUN  ["chmod", "+x", "/build.sh"]

FROM gcr.io/static-cloud-builders/hugo

# NOTE: builder /workspace == container / && container default WORKDIR == ./ 

ARG builder_package_dir
ARG site_dir
ARG site_config_file
ARG themes_dir
ARG theme_dir_name
ARG theme_config_file
ARG content_dir

# Make selected argument values available at RUN time

ENV container_package_dir="/package"
ENV container_build_dir="/build"
ENV site_dir=${site_dir}
ENV site_config_file=${site_config_file}
ENV themes_dir=${themes_dir}
ENV theme_dir_name=${theme_dir_name}
ENV content_dir=${local_test_content_dir}

COPY --from=0 /build.sh /
COPY ["${builder_package_dir}", "${container_package_dir}"]

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

# Test the script at build time
RUN ["/build.sh"]

#ENTRYPOINT ["sh", "-c", "build.sh"]
ENTRYPOINT ["/build.sh"]
#CMD ["a_test_argument_from_exec_AT_BUILD_TIME"]
# If cmd is not over written at docker run time, test content and local build folder will be used
# Easy to set these to /workspace/whatever/blah using CMD override
