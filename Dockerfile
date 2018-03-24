#FROM gcr.io/static-cloud-builders/hugo
FROM alpine

# builder /workspace == container /

ARG builder_package_dir
ARG container_package_dir="/package"

RUN ["echo", "$builder_package_dir"]

COPY ["$builder_package_dir", "$container_package_dir"]

RUN ["ls", "$container_package_dir"]

