# CLion remote docker environment (How to build docker container, run and stop it)
#
# Build and run:
#   docker build -t clion/remote-cpp-env:0.5 -f Dockerfile.remote-cpp-env .
#   docker run -d --cap-add sys_ptrace -p127.0.0.1:2222:22 --name clion_remote_env clion/remote-cpp-env:0.5
#   ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[localhost]:2222"
#
# stop:
#   docker stop clion_remote_env
# 
# ssh credentials (test user):
#   user@password 

FROM ubuntu:22.04

COPY sources.list /etc/apt/sources.list

RUN DEBIAN_FRONTEND="noninteractive" apt update && apt install -y tzdata

RUN apt update \
  && apt install -y ssh \
      python3 \
      build-essential \
      gcc \
      g++ \
      gdb \
      clang \
      make \
      ninja-build \
      cmake \
      autoconf \
      automake \
  && apt clean


RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
      apt install -y \
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
              libfuzzer-13-dev && \
      apt install -y lcov cmake ninja-build libssl-dev zlib1g-dev libcurl4-openssl-dev

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --profile minimal --default-toolchain nightly
ENV CC=/usr/bin/clang-13
ENV CPP=/usr/bin/clang-cpp-13
ENV CXX=/usr/bin/clang++-13
ENV LD=/usr/bin/ld.lld-13


# RUN ( \
#     echo 'LogLevel DEBUG2'; \
#     echo 'PermitRootLogin yes'; \
#     echo 'PasswordAuthentication yes'; \
#     echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
#   ) > /etc/ssh/sshd_config_test_clion \
#   && mkdir /run/sshd
# 
# RUN useradd -m user \
#   && yes password | passwd user
# 
# RUN usermod -s /bin/bash user
# 
# CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_test_clion"]
