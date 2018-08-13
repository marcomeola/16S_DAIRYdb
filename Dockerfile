# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.

#FROM ubuntu:16.04
FROM phusion/baseimage:0.10.1
MAINTAINER Marco Meola (meolam2@gmail.com)

##########
### Configure environment
##########
RUN mkdir /build
WORKDIR /build
ENV BUILD /build
ENV CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
ENV PATH=$CONDA_DIR/bin:$PATH \
    HOME=/home/$NB_USER
TERM=xterm

##########
### System requirements
##########
RUN \
  apt-get update && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get -y upgrade \
  bzip2 \
  gcc \
  make \
  zlib1g-dev \
  libopenblas-dev \
  libncurses5-dev \
  libncursesw5-dev \
  libbz2-dev \
  liblzma-dev \
  htop \
  ca-certificates \
  git \
  curl \
  libpq-dev \
  apache2 \
  apt-utils \
  wget \
  sudo \
  locales \
  fonts-liberation \
  emacs \
  inkscape \
  jed \
  libsm6 \
  libxext-dev \
  libxrender1 \
  lmodern \
  pandoc \
  python-dev \
  texlive-fonts-extra \
  texlive-fonts-recommended \
  texlive-generic-recommended \
  texlive-latex-base \
  texlive-latex-extra \
  texlive-xetex \
  vim \
  unzip \
  fonts-dejavu \
  tzdata \
  gfortran
