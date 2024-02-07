#!/bin/bash
set -e
set -x

source $HOME/setup_env.sh

CMAKE_BINARY=$(which cmake)
export CMAKE_BINARY=$CMAKE_BINARY
sudo -E $CMAKE_BINARY --install $BUILD_WORKSPACE/src/build
