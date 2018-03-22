## BUILD STEP
FROM busybox AS construct_package

# Busybox has git and ssh so these can be used to pull if needed
#  if git is used then the ssh key location must be supplied and available on a volume location as this sequence will not obtain it
#  also if using google container builder, these can be already downloaded and be supplied as a volume location

# Define default resource locations
ARG template_resource_location=""
ARG template_ssh_key=""

ARG site_resource_location=""
ARG site_ssh_key=""

# Check access to resource locations
RUN ["/verify-locations.bash", "$template_resource", "$site_resource"] # ? how to handle working directory?

# Download the hugo components
RUN ["/obtain-resources.bash", "/pull", "$template_resource", "$site_resource"] # ? how to handle working directory?

# Construct the full hugo package by selecting only the folders we need
RUN ["/construct-package.bash", "/package", "$template_resource", "$site_resource"]

# Check the resources are valid hugo
RUN ["/verify-package.bash", "/package", "$template_resource", "$site_resource"] # ? how to handle working directory?

## MAIN STEP
# NOTE: build image will not have git or ssh installed

FROM gcr.io/static-cloud-builders/hugo

COPY --from=0 /package /package

ADD build.bash /build.bash
RUN chmod +x /build.bash

# Build the package
ENTRYPOINT ["build.bash"]

# Using CMD for flexible args at run time, defaults are here
#  if using google container builder, they should be set to a volume location
CMD ["/local/content", "/local/build"]

RUN ["ls", "/local/build"]
