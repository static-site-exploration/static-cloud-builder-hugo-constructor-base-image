FROM alpine

RUN mkdir /util
WORKDIR /util
ADD ["/verify-locations.bash", "."]
RUN ["chmod", "+x", "verify-locations.bash"]

ADD ["/obtain-resources.bash", "."]
RUN ["chmod", "+x", "obtain-resources.bash"]

ADD ["/construct-package.bash", "."]
RUN ["chmod", "+x", "construct-package.bash"]

ADD ["/verify-package.bash", "."]
RUN ["chmod", "+x", "verify-package.bash"]

WORKDIR /
ADD ["/build.sh", "."]
RUN ["chmod", "+x", "build.sh"]
