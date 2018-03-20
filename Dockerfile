## BUILD STEP
FROM busybox AS construct_package

# Define default resource locations
ARG template_resource=""
ARG site_resource=""
ARG content_resource=""

# Check access to resource locations
RUN ["verify-resource-locations.bash", "$template_resource", "$site_resource", "$content_resource"]

# Download the hugo components
RUN ["download-resources.bash", "$template_resource", "$site_resource", "$content_resource"]

# Check downloaded resources are hugo
RUN ["verify-hugo-resources.bash"]

## MAIN STEP
FROM gcr.io/static-cloud-builders/hugo

COPY --from=0 /package /package

# Build the package
ENTRYPOINT ["/hugo"]
CMD ["/package"]
