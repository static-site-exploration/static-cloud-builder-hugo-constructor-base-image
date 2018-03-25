FROM busybox

# Setup the build script
COPY ["/build.sh", "/"]
RUN  ["chmod", "+x", "/build.sh"]

FROM gcr.io/static-cloud-builders/hugo

ARG builder_package_dir
ARG site_dir
ARG site_config_file
ARG themes_dir
ARG theme_dir_name
ARG theme_config_file
ARG content_dir

# Make selected argument values available at RUN time
ENV container_package_dir="/package"
ENV container_build_dir="/tmp/build"
ENV site_dir=${site_dir}
ENV site_config_file=${site_config_file}
ENV themes_dir=${themes_dir}
ENV theme_dir_name=${theme_dir_name}
ENV local_test_content_dir=${content_dir}

# Load the image with build script and site pacakge
COPY --from=0 /build.sh /
COPY ["${builder_package_dir}", "${container_package_dir}"]

# Test the script at build time
RUN ["/build.sh"]

#ENTRYPOINT ["sh", "-c", "build.sh"]
ENTRYPOINT ["/build.sh"]
