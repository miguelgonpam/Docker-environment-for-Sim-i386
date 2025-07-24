FROM ubuntu:22.04

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
        libc6:i386 \
        libncurses5:i386 \
        libstdc++6:i386

RUN useradd -m dev && echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER dev
WORKDIR /home/dev
