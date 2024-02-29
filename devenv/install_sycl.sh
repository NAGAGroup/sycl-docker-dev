#!/bin/bash
set -e
set -x

cmake --build $PIXI_PROJECT_ROOT/llvm-build --target deploy-sycl-toolchain
# cmake --build /usr/local/sycl --target utils/FileCheck/install
# cmake --build /usr/local/sycl --target utils/count/install
# cmake --build /usr/local/sycl --target utils/not/install
# cmake --build /usr/local/sycl --target utils/lit/install
# cmake --build /usr/local/sycl --target utils/llvm-lit/install
# cmake --build /usr/local/sycl --target install-llvm-size
# cmake --build /usr/local/sycl --target install-llvm-cov
# cmake --build /usr/local/sycl --target install-llvm-profdata
cmake --install $PIXI_PROJECT_ROOT --prefix $PIXI_PROJECT_ROOT/.pixi/envs/default

ln -s $PIXI_PROJECT_ROOT/llvm-build/bin/* $PIXI_PROJECT_ROOT/.pixi/envs/default/bin
