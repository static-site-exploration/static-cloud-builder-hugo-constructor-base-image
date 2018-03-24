#FROM gcr.io/static-cloud-builders/hugo
FROM alpine

# builder /workspace == container /

ARG builder_package_dir
RUN echo $builder_package_dir
