FROM gcr.io/static-cloud-builders/hugo
#FROM alpine

# builder /workspace == container /

COPY ["/package", "./package"]
#RUN ["ls", "./package"]
RUN ["test", "./package"]
