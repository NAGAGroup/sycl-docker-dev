#!/bin/bash
set -e
set -x

source $HOME/.bashrc
source /runtimes/oneapi-tbb/env/vars.sh

mkdir -p $BUILD_WORKSPACE/src/build
cd $BUILD_WORKSPACE/src/build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_CXX_COMPILER=clang++ -DWITH_ROCM_BACKEND=OFF -DWITH_CUDA_BACKEND=ON ..
