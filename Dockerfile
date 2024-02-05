FROM ghcr.io/nagagroup/cuda-x11-docker:12.3.1

# Clone Intel LLVM for SYCL
ARG BUILD_WORKSPACE=/tmp/sycl-workspace
RUN mkdir -p $BUILD_WORKSPACE 
WORKDIR $BUILD_WORKSPACE
RUN git clone https://github.com/intel/llvm -b sycl-web/sycl-latest-good --depth=1 $BUILD_WORKSPACE/src

# Install build tools
COPY install_build_tools.sh .
RUN sh install_build_tools.sh

# Install OneAPI OpenCL libraries for CPU and FPGA Emulation
COPY install_intel_drivers.sh .
RUN sh install_intel_drivers.sh


# Build SYCL-LLVM
COPY configure.sh .
RUN sh configure.sh
COPY build_sycl.sh .
RUN sh build_sycl.sh
# COPY run_tests.sh .
# RUN sh run_tests.sh
COPY install_sycl.sh .
RUN source $HOME/.bashrc; sudo -E sh install_sycl.sh

# Setup Example Program
RUN mkdir $HOME/example_program
COPY example_program.cpp $HOME/example_program

# Setup bashrc
RUN echo "export LD_LIBRARY_PATH=/usr/local/lib:$PATH" > $HOME/setup_env.sh
RUN echo "source /runtimes/oneapi-tbb/env/vars.sh" >> $HOME/setup_env.sh
RUN echo "source $HOME/setup_env.sh" >> $HOME/.bashrc

WORKDIR /home/gpu-dev

EXPOSE 2222
CMD sudo /sbin/sshd -D -p 2222
