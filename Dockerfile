#FROM gcr.io/static-cloud-builders/hugo
FROM alpine

# builder /workspace == container /

RUN echo $builder_package_dir
