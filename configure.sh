#!/bin/bash
set -e
set -x

export CUDA_LIB_PATH=/usr/local/cuda/lib64/stubs
export CC=gcc
export CXX=g++
source $HOME/.bashrc
source /runtimes/oneapi-tbb/env/vars.sh

mkdir -p $BUILD_WORKSPACE/build
cd $BUILD_WORKSPACE/build
python3 $BUILD_WORKSPACE/src/buildbot/configure.py -w $BUILD_WORKSPACE \
	-s $BUILD_WORKSPACE/src -o $BUILD_WORKSPACE/build -t Release \
	--cuda \
	--cmake-opt="-DLLVM_INSTALL_UTILS=ON" \
	--cmake-opt="-DSYCL_PI_TESTS=OFF" \
	--cmake-opt="-DLLVM_ENABLE_ASSERTIONS=OFF" \
	--cmake-opt="-DLLVM_ENABLE_DUMP=OFF" \
	--cmake-opt="-DLLVM_BUILD_LLVM_DYLIB=ON" \
	--cmake-opt="-DCMAKE_INSTALL_PREFIX=/usr" \
	--llvm-external-projects="clang-tools-extra,lld,lldb"
