# Build from the latest ubuntu release
FROM ubuntu:latest

# Install items requiring root access

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    apt-utils \
    fswatch \
    g++ \
    git \
    libreadline-dev \
    make \
    nodejs \
    npm \
    rbenv \
    wget \
    zlib1g-dev

RUN apt-get install -y libyaml-dev

RUN npm install -g n
# Turn off XZ compression because 20.5.1 had a broken link
RUN export N_USE_XZ=0; n latest

RUN npm install -g npm@latest
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
RUN mkdir -p "$(rbenv root)"/plugins
RUN git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
#  Install latest ruby
RUN rbenv install $(rbenv install -l | grep -v - | tail -1)
RUN rbenv global  $(rbenv install -l | grep -v - | tail -1)
#  Update rubygems
RUN (eval "$(rbenv init -)"; gem install rubygems-update)
RUN (eval "$(rbenv init -)"; update_rubygems)
RUN (eval "$(rbenv init -)"; gem update --system)
#  Install bundler in global ruby
RUN (eval "$(rbenv init -)"; gem install bundler)

# Install conda
RUN mkdir $HOME/.conda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ./miniconda.sh
RUN chmod +x ./miniconda.sh
# https://docs.anaconda.com/anaconda/install/silent-mode/
RUN bash ./miniconda.sh -b -p ./miniconda3
RUN eval "$(~/miniconda3/bin/conda shell.bash hook)"; conda init; \
    conda update -n base -c defaults conda

# Add version file last to avoid cache invalidation for minor releases
ADD VERSION .
