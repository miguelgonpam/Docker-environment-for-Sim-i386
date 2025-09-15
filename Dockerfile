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
        openssh-server \
        linux-source \
        libc6:i386 \
        libstdc++6:i386

RUN useradd -m dev && echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER dev

WORKDIR /home/dev

RUN git clone https://github.com/richfelker/musl-cross-make && git clone https://github.com/miguelgonpam/Sim-i386-32bit

WORKDIR /home/dev/musl-cross-make


RUN echo "TARGET=i386-linux-musl" > config.mak
RUN echo "OUTPUT=/home/dev/utils" >> config.mak
RUN echo "COMMON_CONFIG+=--disable-nls" >> config.mak

RUN cat -A config.mak
RUN make
RUN sudo make install
