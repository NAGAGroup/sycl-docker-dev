#!/bin/bash
set -e
set -x

export CUDA_LIB_PATH=/usr/local/cuda/lib64/stubs
export CC=gcc
export CXX=g++
source $HOME/.bashrc
source /runtimes/oneapi-tbb/env/vars.sh

export PATH=/usr/local/bin:$PATH
cmake --build $BUILD_WORKSPACE/build --target deploy-sycl-toolchain
cmake --build $BUILD_WORKSPACE/build --target utils/FileCheck/install
cmake --build $BUILD_WORKSPACE/build --target utils/count/install
cmake --build $BUILD_WORKSPACE/build --target utils/not/install
cmake --build $BUILD_WORKSPACE/build --target utils/lit/install
cmake --build $BUILD_WORKSPACE/build --target utils/llvm-lit/install
cmake --build $BUILD_WORKSPACE/build --target install-llvm-size
cmake --build $BUILD_WORKSPACE/build --target install-llvm-cov
cmake --build $BUILD_WORKSPACE/build --target install-llvm-profdata
cmake --install $BUILD_WORKSPACE/build
