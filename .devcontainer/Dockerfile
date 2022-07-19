FROM ubuntu:22.04

COPY sources.list /etc/apt/sources.list

RUN DEBIAN_FRONTEND="noninteractive" apt update && apt install -y tzdata

RUN apt update \
  && apt install -y ssh \
      python3 \
      git \
      build-essential \
      gcc \
      g++ \
      gdb \
      make \
      autoconf \
      automake \
  && apt clean


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

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --profile minimal --default-toolchain nightly

ENV CC=/usr/bin/clang-13
ENV CPP=/usr/bin/clang-cpp-13
ENV CXX=/usr/bin/clang++-13
ENV LD=/usr/bin/ld.lld-13
