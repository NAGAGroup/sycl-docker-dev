#!/bin/bash
set -e

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

sudo -E sh $DPCPP_SOURCE/llvm/devops/scripts/install_drivers.sh --cpu --fpga-emu
