#!/bin/bash
set -e

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export LD_LIBRARY_PATH=
export CUDA_LIB_PATH=/usr/local/cuda/lib64/stubs
export CC=gcc
export CXX=g++
source /opt/rh/gcc-toolset-12/enable
source /runtimes/oneapi-tbb/env/vars.sh

cmake --build $DPCPP_SOURCE/llvm/build --target deploy-sycl-toolchain
cmake --build $DPCPP_SOURCE/llvm/build --target utils/FileCheck/install
cmake --build $DPCPP_SOURCE/llvm/build --target utils/count/install
cmake --build $DPCPP_SOURCE/llvm/build --target utils/not/install
cmake --build $DPCPP_SOURCE/llvm/build --target utils/lit/install
cmake --build $DPCPP_SOURCE/llvm/build --target utils/llvm-lit/install
cmake --build $DPCPP_SOURCE/llvm/build --target install-llvm-size
cmake --build $DPCPP_SOURCE/llvm/build --target install-llvm-cov
cmake --build $DPCPP_SOURCE/llvm/build --target install-llvm-profdata
cmake --build $DPCPP_SOURCE/llvm/build --target install-compiler-rt
cmake --build $DPCPP_SOURCE/llvm/build --target install-clang-libraries
cmake --build $DPCPP_SOURCE/llvm/build --target install-llvm-libraries
cmake --build $DPCPP_SOURCE/llvm/build --target install-clang-format
cmake --build $DPCPP_SOURCE/llvm/build --target install-clang-tidy

ln -s $DPCPP_SOURCE/llvm/build $HOME/.local/share/sycl
