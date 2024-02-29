#!/bin/bash
set -e
set -x

cmake --build $PIXI_PROJECT_ROOT/llvm-build -- -j12
#cmake --build /usr/local/sycl --target check-llvm
#cmake --build /usr/local/sycl --target check-clang
#cmake --build /usr/local/sycl --target check-sycl
#cmake --build /usr/local/sycl --target check-llvm-spirv
#cmake --build /usr/local/sycl --target check-xptifw
#cmake --build /usr/local/sycl --target check-libclc
#cmake --build /usr/local/sycl --target check-libdevice
