FROM ubuntu:16.04
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
  wget \
  sudo \
  locales \
  fonts-liberation \
  emacs \
  git \
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
RUN rm -rf /var/lib/apt/lists/*
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

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

##########
### Install apache2
##########
# RUN apt-get install -y apache2

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

##########
### Install SeekDeep
##########

RUN echo Europe/Berlin | sudo tee  /etc/timezone  && sudo dpkg-reconfigure --frontend noninteractive tzdata
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get -y autoremove
RUN apt-get install -y build-essential software-properties-common python-software-properties
RUN apt-get install -y git make

RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y
RUN apt-get update && sudo apt-get install -y g++-7

RUN cd ~
RUN git clone https://github.com/bailey-lab/SeekDeep
RUN cd SeekDeep

RUN ./setup.py --libs cmake:3.7.2 --symlinkBin
RUN echo "" >> ~/.profile && echo "#Add SeekDeep bin to your path" >> ~/.profile && echo "export PATH=\"$(pwd)/bin:\$PATH\"" >> ~/.profile
RUN . ~/.profile
RUN ./setup.py --addBashCompletion
RUN ./install.sh 7

#add other tools
RUN ./setup.py --libs muscle:3.8.31 --symlinkBin --overWrite

##########
### Install Samtools
##########

RUN wget https://github.com/samtools/samtools/releases/download/1.5/samtools-1.5.tar.bz2
RUN tar -xjvf samtools-1.5.tar.bz2
WORKDIR /build/samtools-1.5
RUN make
RUN ln -s /build/samtools-1.5/samtools /usr/bin/samtools
WORKDIR /build
#cleanup
RUN rm samtools-1.5.tar.bz2
