#FROM gcr.io/static-cloud-builders/hugo
FROM alpine

# This lists the container built so far
RUN echo "FROM DOCKERFILE: LISTING ." && ls -a .

RUN echo "FROM DOCKERFILE: WORKSPACE" && ls -a /workspace
