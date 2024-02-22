#!/bin/bash
set -e
set -x

export CUDA_LIB_PATH=/usr/local/cuda/lib64/stubs
export CC=gcc
export CXX=g++

mkdir -p $BUILD_WORKSPACE/build
cd $BUILD_WORKSPACE/build
python3 $BUILD_WORKSPACE/src/buildbot/configure.py -w $BUILD_WORKSPACE \
	-s $BUILD_WORKSPACE/src -o /usr/local/sycl -t Release \
	--cuda \
	--cmake-opt="-DLLVM_INSTALL_UTILS=ON" \
	--cmake-opt="-DSYCL_PI_TESTS=OFF" \
	--cmake-opt="-DLLVM_ENABLE_ASSERTIONS=OFF" \
	--llvm-external-projects="clang;clang-tools-extra;compiler-rt" \
	--cmake-opt="-DLLVM_ENALBE_RUNTIMES=\"compiler-rt\""
