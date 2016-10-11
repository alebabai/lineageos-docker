FROM ubuntu:16.04
MAINTAINER Alexander Babai <aliaksandr.babai@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Args defenition
ARG description="Docker image with CM build environment"
ARG external_dir="include"
ARG internal_dir=".init-cm"
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
    screenfetch \
    ssh \
    sudo \
    wget

# Add new user
RUN useradd -ms /bin/bash $user && \
    echo "$user ALL=NOPASSWD: ALL" > /etc/sudoers.d/$user

# Initialize environment
ADD $external_dir /home/$user/$internal_dir
RUN mkdir -p /home/$user/bin && \
    curl https://storage.googleapis.com/git-repo-downloads/repo > /home/$user/bin/repo && \
    chmod a+x /home/$user/bin/repo && \
    mkdir -p /home/$user/$workdir/.ccache && \
    mkdir -p /home/$user/$workdir/out && \
    chown -R $user:$user /home/$user && \
    echo ". ~/$internal_dir/init-environment.sh" >> /home/$user/.profile

# Volumes defenition
VOLUME /home/$user/android
VOLUME /home/$user/android/.ccache
VOLUME /home/$user/android/out

USER $user
WORKDIR /home/$user/$workdir
