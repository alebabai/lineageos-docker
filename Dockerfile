FROM ubuntu:16.04
MAINTAINER Alexander Babai <aliaksandr.babai@gmail.com>

# Args defenition
ARG description="Docker image with CM build environment"
ARG user="docker-cm"
ARG version="0.0-AURORA"
ARG workdir="android"

LABEL description=$description \
      version=$version

# Install commons build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends\
    apt-utils \
    bison \
    build-essential \
    curl \
    flex \
    git \
    gnupg \
    gperf \
    libesd0-dev \
    liblz4-tool \
    libncurses5-dev \
    libsdl1.2-dev \
    libwxgtk3.0-dev \
    libxml2 \
    libxml2-utils \
    lzop \
    maven \
    openjdk-8-jdk \
    pngcrush \
    schedtool  \
    squashfs-tools \
    xsltproc \
    zip \
    zlib1g-dev

# Install build dependencies for 64-bit systems
RUN apt-get install -y --no-install-recommends\
    g++-multilib \
    gcc-multilib \
    lib32ncurses5-dev \
    lib32readline6-dev \
    lib32z1-dev