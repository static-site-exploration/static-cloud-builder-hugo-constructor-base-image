## BUILD STEP
FROM busybox AS construct_package

# Define default resource locations
ARG template_resource_location=""
ARG site_resource_location=""
ARG content_resource_location=""

# Construct an array of supplied argumnets
#ENV 

# Check access to resource locations
RUN ["verify-resource-locations.bash", "$template_resource", "$site_resource", "$content_resource"] # ? how to handle working directory?

# Download the hugo components
RUN ["download-resources.bash", "/build", "$template_resource", "$site_resource", "$content_resource"] # ? how to handle working directory?

# Check downloaded resources are hugo
RUN ["verify-hugo-resources.bash", "/build", "$template_resource", "$site_resource", "$content_resource"] # ? how to handle working directory?

# Construct the full hugo package by selecting only the folders we need
RUN ["construct-hugo-package.bash", "/package", "$template_resource", "$site_resource", "$content_resource"]

## MAIN STEP
FROM gcr.io/static-cloud-builders/hugo

COPY --from=0 /package /package

# Build the package
ENTRYPOINT ["/hugo"]
CMD ["/package"]
