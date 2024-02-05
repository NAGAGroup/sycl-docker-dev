#!/bin/bash
set -e
set -x

export CUDA_LIB_PATH=/usr/local/cuda/lib64/stubs
export CC=gcc
export CXX=g++
source $HOME/.bashrc
source /runtimes/oneapi-tbb/env/vars.sh

cmake --build $BUILD_WORKSPACE/build -- -j12
#cmake --build $BUILD_WORKSPACE/build --target check-llvm
#cmake --build $GITHUB_WORKSPACE/build --target check-clang
#cmake --build $GITHUB_WORKSPACE/build --target check-sycl
#cmake --build $GITHUB_WORKSPACE/build --target check-llvm-spirv
#cmake --build $GITHUB_WORKSPACE/build --target check-xptifw
#cmake --build $GITHUB_WORKSPACE/build --target check-libclc
#cmake --build $GITHUB_WORKSPACE/build --target check-libdevice
