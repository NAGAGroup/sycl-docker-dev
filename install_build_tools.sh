#!/bin/bash
set -e
set -x

# For more information on where this script
# came from, see devops/scripts/install_build_tools.sh
# in llvm sycl repo

set -e

sudo dnf install -y ccache ocl-icd-devel libffi-devel libva-devel jq procps-ng
