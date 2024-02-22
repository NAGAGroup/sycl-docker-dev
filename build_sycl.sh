#!/bin/bash
set -e
set -x

cmake --build $BUILD_WORKSPACE/src/build -- -j12
#cmake --build $BUILD_WORKSPACE/build --target check-llvm
#cmake --build $GITHUB_WORKSPACE/build --target check-clang
#cmake --build $GITHUB_WORKSPACE/build --target check-sycl
#cmake --build $GITHUB_WORKSPACE/build --target check-llvm-spirv
#cmake --build $GITHUB_WORKSPACE/build --target check-xptifw
#cmake --build $GITHUB_WORKSPACE/build --target check-libclc
#cmake --build $GITHUB_WORKSPACE/build --target check-libdevice
