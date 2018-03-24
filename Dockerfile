#FROM gcr.io/static-cloud-builders/hugo
FROM alpine

COPY ["/package", "."]
RUN ["ls", "."]
