#FROM gcr.io/static-cloud-builders/hugo
FROM alpine

RUN echo "FROM DOCKERFILE: LISTING ." && ls -a .
