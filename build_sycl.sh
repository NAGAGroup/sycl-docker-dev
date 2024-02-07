#!/bin/bash
set -e
set -x

export CUDA_LIB_PATH=/usr/local/cuda/lib64/stubs
export CC=gcc
export CXX=g++
source $HOME/setup_env.sh

cmake --build /usr/local/sycl -- -j12
#cmake --build /usr/local/sycl --target check-llvm
#cmake --build /usr/local/sycl --target check-clang
#cmake --build /usr/local/sycl --target check-sycl
#cmake --build /usr/local/sycl --target check-llvm-spirv
#cmake --build /usr/local/sycl --target check-xptifw
#cmake --build /usr/local/sycl --target check-libclc
#cmake --build /usr/local/sycl --target check-libdevice
