#FROM gcr.io/static-cloud-builders/hugo
FROM alpine

# This lists the container built so far
RUN echo "FROM DOCKERFILE: LISTING WORKDIR"
RUN ls .

RUN echo "FROM DOCKERFILE: WORKSPACE"
RUN ls /workspace
