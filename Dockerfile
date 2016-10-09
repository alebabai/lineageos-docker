FROM ubuntu:16.04
MAINTAINER Alexander Babai <aliaksandr.babai@gmail.com>

# Args defenition
ARG description="Docker image with CM build environment"
ARG user="docker-cm"
ARG version="0.0-AURORA"
ARG workdir="android"

LABEL description=$description \
      version=$version
