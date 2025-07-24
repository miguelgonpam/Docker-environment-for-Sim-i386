FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && \
    apt update && \
    apt upgrade -y && \
    apt install -y \
        build-essential \
        gcc-multilib \
        g++-multilib \
        libcapstone-dev \
        gdb \
        nano \
        make \
        curl \
        wget \
        git \
        sudo \
        strace \
        ltrace \
        file \
        vim \
        less \
        man \
        linux-source \
        libc6:i386 \
        libstdc++6:i386

RUN useradd -m dev && echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER dev

RUN cd /usr/src  && \
        sudo tar -xjf linux-source-6.8.0.tar.bz2 && \
        sudo cp -r /usr/src/linux-source-6.8.0/include/* /usr/include/

WORKDIR /home/dev
