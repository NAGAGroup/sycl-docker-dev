#!/bin/bash

# For more information on where this script
# came from, see devops/containers/ubuntu2204_intel_drivers.Dockerfile
# in llvm sycl repo

set -e
set -x

export compute_runtime_tag=latest
export igc_tag=latest
export cm_tag=latest
export level_zero_tag=latest
export tbb_tag=latest
export fpgaemu_tag=latest
export cpu_tag=latest

sudo mkdir /runtimes
sudo mkdir -p /etc/OpenCL/vendors
export INSTALL_LOCATION=/runtimes

sudo -E sh $BUILD_WORKSPACE/src/devops/scripts/install_drivers.sh --cpu --fpga-emu
