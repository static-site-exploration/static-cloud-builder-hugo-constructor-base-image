#FROM gcr.io/static-cloud-builders/hugo
FROM alpine

COPY ["/build.sh", "."]
RUN ["ls", "."]
RUN ["ls", "/"]
