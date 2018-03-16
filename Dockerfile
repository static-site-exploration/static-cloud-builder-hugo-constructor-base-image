#FROM busybox

# Default rep urls
ARG template_location=""
ARG template_location_type="" #git gs or file

ARG site_location=""
ARG site_location_type=""

ARG content_location=""
ARG content_location_type=""

# Use

FROM gcr.io/static-cloud-builders/hugo
#ARGS 

#CP from step=0
