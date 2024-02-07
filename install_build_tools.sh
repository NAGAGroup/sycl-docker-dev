#!/bin/bash

set -e
set -x

source $HOME/setup_env.sh

mamba install cmake compilers llvmdev llvm-tools clang-tools clangdev clang clangxx compiler-rt boost llvm-spirv spirv-tools spirv-headers libllvmspirv openmp intel-opencl-rt -y
