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
ENV HOME=/root TERM=xterm
ENV BUILD /build
ENV CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
ENV PATH=$CONDA_DIR/bin:$PATH \
    HOME=/home/$NB_USER

##########
### set proper timezone
##########
    RUN echo Europe/Zurich > /etc/timezone && sudo dpkg-reconfigure --frontend noninteractive tzdata
