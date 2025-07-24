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


RUN cd /usr/src  &&  sudo tar -xjf linux-source-6.8.0.tar.bz2

RUN sudo mkdir /usr/include/uapi && sudo mkdir /usr/include/vdso && sudo mkdir /usr/include/generated && \
        sudo cp -r /usr/src/linux-source-6.8.0/include/* /usr/include/ && \
        sudo ln -s /usr/include/asm-generic /usr/include/asm && \
        sudo cp -r /usr/src/linux-source-6.8.0/arch/x86/entry/* ~/



WORKDIR /home/dev
