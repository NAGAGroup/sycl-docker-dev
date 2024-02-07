#!/bin/bash
set -e
set -x

source $HOME/setup_env.sh

mkdir -p $BUILD_WORKSPACE/src/build
cd $BUILD_WORKSPACE/src/build
cmake -DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/usr/local \
	-DCMAKE_CXX_COMPILER=clang++ \
	-DWITH_ROCM_BACKEND=OFF \
	-DWITH_CUDA_BACKEND=ON \
	-DWITH_OPENCL_BACKEND=ON \
	-DLLVM_DIR=$CONDA_PREFIX/lib/cmake/llvm \
	..
