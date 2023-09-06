#!/bin/bash

# install extra packages
sudo dnf install python3-psutil psutils perl -y

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export LD_LIBRARY_PATH=
export CUDA_LIB_PATH=/usr/local/cuda/lib64/stubs
export CC=gcc
export CXX=g++
source ~/setup_env.sh

cd $DPCPP_SOURCE/llvm/build

cmake --build . --target check-llvm
cmake --build . --target check-clang
cmake --build . --target check-sycl
cmake --build . --target check-llvm-spirv
cmake --build . --target check-xptifw
cmake --build . --target check-libclc
