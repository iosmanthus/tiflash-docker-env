FROM ubuntu:22.04

COPY sources.list /etc/apt/sources.list

RUN DEBIAN_FRONTEND="noninteractive" apt update && apt install -y tzdata

RUN apt update \
  && apt install -y ssh \
      python3 \
      zsh \
      git \
      build-essential \
      gcc \
      g++ \
      gdb \
      make \
      autoconf \
      automake \
  && apt clean

ARG USERNAME=iosmanthus
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
      apt install -y \
              cmake \
              ninja-build \
              curl \
              clang-13 \
              lldb-13 \
              lld-13 \
              clang-tools-13 \
              clang-13-doc \
              libclang-common-13-dev \
              libclang-13-dev \
              libclang1-13 \
              clang-format-13 \
              clangd-13 \
              clang-tidy-13 \
              libc++-13-dev \
              libc++abi-13-dev \
              libomp-13-dev \
              llvm-13-dev \
              libfuzzer-13-dev \
              lcov \
              zlib1g-dev 
RUN sudo apt-get update && sudo apt-get install gnupg2 -y

ENV CC=/usr/bin/clang-13
ENV CPP=/usr/bin/clang-cpp-13
ENV CXX=/usr/bin/clang++-13
ENV LD=/usr/bin/ld.lld-13

USER $USERNAME

RUN sudo chsh -s /usr/bin/bash
RUN git config --global --add safe.directory /workspaces/tiflash-docker-env/tiflash
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --profile minimal --default-toolchain nightly
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"