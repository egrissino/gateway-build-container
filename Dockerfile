FROM ubuntu:latest

ARG USERNAME=user
ARG UNAME=user
ARG EMAIL=hello@example.com
ENV USER=${USERNAME}

RUN apt-get -y update 
RUN apt-get -y upgrade
RUN apt-get install -y build-essential
RUN apt-get install -y chrpath diffstat gawk lz4 locales
RUN apt-get install -y cpio file git wget zstd nano screen iputils-ping iproute2
RUN apt-get install -y python3 python3-pip python3-venv
RUN apt-get install -y repo libncurses-dev pkg-config

RUN apt-get install git
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US:en  
ENV LC_ALL=en_US.UTF-8

RUN userdel ubuntu
RUN adduser ${USER}

RUN git config --global user.email "${EMAIL}"
RUN git config --global user.name "${UNAME}"

VOLUME "/home/${USER}/yoctoworkspace"
WORKDIR "/home/${USER}/yoctoworkspace"

COPY buildyocto.sh /home/${USER}/buildyocto.sh
RUN chmod +x /home/${USER}/buildyocto.sh
RUN echo "cp /home/${USER}/buildyocto.sh /home/${USER}/yoctoworkspace/buildyocto.sh" >> /home/${USER}/.bashrc

USER ${USER}

RUN mkdir -p /home/${USER}/env
RUN cd /home/${USER}/env && python3 -m venv ./
ENV PATH="~/env/bin:$PATH"
COPY requirements.txt /home/${USER}/requirements.txt
RUN /home/${USER}/env/bin/python3 -m pip install -r /home/${USER}/requirements.txt
