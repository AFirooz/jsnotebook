FROM ubuntu:22.04

# set the working directory inside the container. This is where subsequent commands will be executed from and where application files will be placed
WORKDIR /app

# set the docker image label
LABEL nome="jsjupyter"

# prevent interactive prompts when installing packages using apt-get
ARG DEBIAN_FRONTEND=noninteractive

# install Python
RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get install -y python3.10 python3-pip sudo tzdata cmake curl unzip tar

# create a new user named 'docker' with password 'docker' and add them to the sudo group
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# allow members of the sudo group to execute commands without a password prompt
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER docker

# install Jupyter
RUN sudo pip3 install notebook

# install node.js
RUN sudo apt-get install -y node.js npm \
  && sudo npm cache clean -f \  # clean the npm cache to ensure a fresh install and reduce image size
  && sudo npm i --unsafe-perm \
  && sudo npm install -g n \
  && sudo n 20.9.0

# install ijavascript
RUN sudo npm install -g ijavascript@5.2.1 --unsafe-perm=true --allow-root
RUN sudo ijsinstall

# install tslib
RUN sudo npm install -g tslab@1.0.22 --unsafe-perm=true --allow-root
RUN sudo tslab install

# install demo kernel
RUN sudo curl -fsSL https://deno.land/install.sh | sh
# RUN sudo /home/docker/.deno/bin/deno jupyter --install

