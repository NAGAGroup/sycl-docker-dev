#!/bin/bash
set -e

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export LD_LIBRARY_PATH=
export CUDA_LIB_PATH=/usr/local/cuda/lib64/stubs
export CC=gcc
export CXX=g++
source /opt/rh/gcc-toolset-12/enable
source /runtimes/oneapi-tbb/env/vars.sh

python3 $DPCPP_SOURCE/llvm/buildbot/configure.py --cuda -t Release \
	--cmake-opt="-DLLVM_INSTALL_UTILS=ON" \
	--cmake-opt="-DSYCL_PI_TESTS=OFF" \
	--cmake-opt="-DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda"
cmake --build $DPCPP_SOURCE/llvm/build
cmake --build $DPCPP_SOURCE/llvm/build --target deploy-sycl-toolchain
