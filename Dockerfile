FROM busybox AS construct_package

# Default rep urls
ARG template_location=""
ARG template_location_type="" #git gs or file

ARG site_location=""
ARG site_location_type=""

ARG content_location=""
ARG content_location_type=""

# Use

FROM gcr.io/static-cloud-builders/hugo

COPY --from=0 /package /package

# Build the package
ENTRYPOINT ["/hugo"]
CMD ["/package"]
