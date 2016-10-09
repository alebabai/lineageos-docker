FROM ubuntu:16.04
MAINTAINER Alexander Babai <aliaksandr.babai@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Args defenition
ARG description="Docker image with CM build environment"
ARG group="users"
ARG user="docker-cm"
ARG version="0.0-AURORA"
ARG workdir="android"

# Metainformation
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

# Install additional useful stuff
RUN apt-get install -y --no-install-recommends \
    android-tools-adb \
    android-tools-adbd \
    android-tools-fastboot \
    android-tools-fsutils \
    bash-completion \
    ccache \
    mc \
    nano \
    ssh \
    sudo \
    wget

# Add new group, user and setup workdir
RUN groupadd -f $group && \
    useradd -m -g $group -s /bin/bash $user && \
    echo "$user ALL=NOPASSWD: ALL" > /etc/sudoers.d/$group && \
    mkdir -p /home/$user/bin && \
    curl https://storage.googleapis.com/git-repo-downloads/repo > /home/$user/bin/repo && \
    chmod a+x /home/$user/bin/repo && \
    chown -R $user:$group /home/$user

USER $user
WORKDIR $workdir
