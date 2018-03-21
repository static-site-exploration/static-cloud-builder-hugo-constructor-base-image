## BUILD STEP
FROM busybox AS construct_package

# Define default resource locations
ARG template_resource_location=""
ARG template_ssh_key=""

ARG site_resource_location=""
ARG site_ssh_key=""

ARG content_resource_location=""
ARG content_ssh_key=""

# Check access to resource locations
RUN ["verify-resource-locations.bash", "$template_resource", "$site_resource", "$content_resource"] # ? how to handle working directory?

# Download the hugo components
RUN ["download-resources.bash", "/build", "$template_resource", "$site_resource", "$content_resource"] # ? how to handle working directory?

# Check downloaded resources are hugo
RUN ["verify-hugo-resources.bash", "/build", "$template_resource", "$site_resource", "$content_resource"] # ? how to handle working directory?

# Construct the full hugo package by selecting only the folders we need
RUN ["construct-hugo-package.bash", "/package", "$template_resource", "$site_resource", "$content_resource"]

## MAIN STEP
# NOTE: build image will not have git or ssh installed

FROM gcr.io/static-cloud-builders/hugo

COPY --from=0 /package /package

ADD verify-ssh.bash /build.bash
RUN chmod +x /build.bash

ENV content_ssh_key=$ssh_deploy_key

# Build the package
ENTRYPOINT ["build.bash"]

# Using CMD for flexible args at run time, defaults are here
CMD ["/local/content", "/local/build"]
