FROM ubuntu:16.04
MAINTAINER Alexander Babai <aliaksandr.babai@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Arguments defenition
ARG description="Docker image with CM build environment"
ARG external_dir="include"
ARG internal_dir=".init-cm"
ARG shared_dir="shared"
ARG user="docker-cm"
ARG version="0.0-AURORA"
ARG work_dir="android"

# Environment variables defenition (do not rearrange!)
ENV USER=$user
ENV USER_HOME=/home/$USER
ENV SHARED_DIR=$USER_HOME/$shared_dir
ENV WORK_DIR=$USER_HOME/$work_dir
ENV CCACHE_DIR=$WORK_DIR/.ccache
ENV INIT_DIR=$WORK_DIR/$internal_dir
ENV OUT_DIR=$WORK_DIR/out

# Metainformation
LABEL description=$description \
      version=$version

# Install commons build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
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
    unzip \
    xsltproc \
    zip \
    zlib1g-dev

# Install build dependencies for 64-bit systems
RUN apt-get install -y --no-install-recommends \
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
RUN useradd -ms /bin/bash $USER && \
    echo "$USER ALL=NOPASSWD: ALL" > /etc/sudoers.d/$USER

# Initialize environment
ADD $external_dir $INIT_DIR
RUN mkdir -p $USER_HOME/bin && \
    curl https://storage.googleapis.com/git-repo-downloads/repo > /home/$user/bin/repo && \
    chmod a+x $USER_HOME/bin/repo && \
    mkdir -p $SHARED_DIR && \
    mkdir -p $CCACHE_DIR && \
    mkdir -p $OUT_DIR && \
    chmod -R 775 $USER_HOME && \
    chown -R $USER:$USER $USER_HOME && \
    echo ". $INIT_DIR/init-environment.sh" >> $USER_HOME/.profile

# Volumes defenition
VOLUME $SHARED_DIR
VOLUME $WORK_DIR
VOLUME $CCACHE_DIR
VOLUME $OUT_DIR

# Configure start up
USER $USER
WORKDIR $WORK_DIR
ENTRYPOINT ["/bin/bash"]
CMD ["-l"]
