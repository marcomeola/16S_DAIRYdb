# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.

#FROM ubuntu:16.04
FROM phusion/baseimage:0.10.1
MAINTAINER Marco Meola (meolam2@gmail.com)

##########
### System requirements
##########
RUN apt-get update
RUN apt-get install -y wget \
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
  build-essential \
  apache2 \
  apt-utils \
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

RUN apt-get update --fix-missing
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen


##########
### Install apache2
##########
RUN apt-get update && \
  apt-get install -y apache2 apache2-utils && \
  a2enmod proxy && a2enmod proxy_http

##########
### expose port 80
##########
EXPOSE 80

##########
### Launch the webserver
##########
ENTRYPOINT service apache2 start && /bin/bash


##########
### Install Tini
##########
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

##########
### Install Metaxa2_2.2
##########
RUN curl http://microbiology.se/sw/Metaxa2_2.2-beta10.tar.gz --output Metaxa2_2.2-beta10.tar.gz
RUN tar xvfz Metaxa2_2.2-beta10.tar.gz
RUN cd Metaxa2_2.2 && ./install_metaxa2
RUN rm Metaxa2_2.2-beta10.tar.gz

##########
### Install Samtools
##########

RUN wget https://github.com/samtools/samtools/releases/download/1.5/samtools-1.5.tar.bz2
RUN tar -xjvf samtools-1.5.tar.bz2
WORKDIR /build/samtools-1.5
RUN apt-get install -y git make
RUN make
RUN ln -s /build/samtools-1.5/samtools /usr/bin/samtools
WORKDIR /build
#cleanup
RUN rm samtools-1.5.tar.bz2
