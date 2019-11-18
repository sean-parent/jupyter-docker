# Build from the latest ubuntu release
FROM ubuntu:latest

# Install items requiring root access

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends -y \
    apt-utils \
    fswatch \
    npm \
    rbenv \
    ruby-build \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g browser-sync

# Create a user "app" so everything is not running at root
RUN useradd -ms /bin/bash app
USER app
WORKDIR /home/app

# Set UTF language (assumed by jekyll)
ENV LC_ALL "C.UTF-8"
ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en_US.UTF-8"

# Install ruby environment
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
#  Install latest ruby
RUN rbenv install $(rbenv install -l | grep -v - | tail -1)
RUN rbenv global  $(rbenv install -l | grep -v - | tail -1)
#  Install bundler in global ruby
RUN (eval "$(rbenv init -)"; gem install bundler)

# Install conda
RUN mkdir $HOME/.conda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ./miniconda.sh
RUN chmod +x ./miniconda.sh
# https://docs.anaconda.com/anaconda/install/silent-mode/
RUN bash ./miniconda.sh -b -p ./miniconda3
RUN eval "$(./miniconda3/bin/conda shell.bash hook)"
RUN ./miniconda3/bin/conda init
