#!/bin/bash
set -e
set -x

export LD_LIBRARY_PATH=""
export CUDA_LIB_PATH=$PIXI_PROJECT_ROOT/.pixi/envs/default/lib/stubs
export CC=gcc
export CXX=g++

cd $PIXI_PROJECT_ROOT
mkdir -p llvm-build
python3 llvm-source/buildbot/configure.py -w $PIXI_PROJECT_ROOT \
	-s llvm-source -o llvm-build -t Release \
	--cuda \
	--cmake-opt="-DLLVM_INSTALL_UTILS=ON" \
	--cmake-opt="-DSYCL_PI_TESTS=OFF" \
	--cmake-opt="-DLLVM_ENABLE_ASSERTIONS=OFF" \
	--llvm-external-projects="clang;clang-tools-extra;compiler-rt"
