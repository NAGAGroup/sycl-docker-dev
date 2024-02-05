#!/bin/bash

set -e
set -x

source $HOME/.bashrc

mamba install cmake compilers llvmdev llvm-tools clang-tools clangdev clang clangxx boost llvm-spirv spirv-tools spirv-headers libllvmspirv openmp -y
