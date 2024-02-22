FROM ghcr.io/nagagroup/cuda-x11-docker:12.3.1

# Clone Intel LLVM for SYCL
ARG BUILD_WORKSPACE=/tmp/sycl-workspace
RUN mkdir -p $BUILD_WORKSPACE
RUN sudo mkdir -p /usr/local/sycl
RUN sudo chown -R gpu-dev:gpu-dev /usr/local/sycl
WORKDIR $BUILD_WORKSPACE
RUN git clone https://github.com/intel/llvm -b sycl-web/sycl-latest-good --depth=1 $BUILD_WORKSPACE/src

# Install build tools
COPY install_build_tools.sh .
RUN sh install_build_tools.sh

# Environment setup
RUN echo "export LD_LIBRARY_PATH=/usr/local/sycl/lib:/usr/local/sycl/lib64:\$LD_LIBRARY_PATH" > /home/gpu-dev/setup_env.sh
RUN echo "export PATH=/usr/local/bin:\$PATH" >> /home/gpu-dev/setup_env.sh
RUN echo "export PATH=/usr/local/sycl/bin:\$PATH" >> /home/gpu-dev/setup_env.sh
RUN echo "source /runtimes/oneapi-tbb/env/vars.sh" >> /home/gpu-dev/setup_env.sh
RUN echo "source /home/gpu-dev/setup_env.sh" >> /home/gpu-dev/.bashrc

# Install OneAPI OpenCL libraries for CPU and FPGA Emulation
COPY install_intel_drivers.sh .
RUN sh install_intel_drivers.sh


# Build SYCL-LLVM
RUN sudo mkdir -p /usr/local/sycl
COPY configure.sh .
RUN bash --login -c "sh configure.sh"
COPY build_sycl.sh .
RUN bash --login -c "sh build_sycl.sh"
# COPY run_tests.sh .
# RUN sh run_tests.sh
COPY install_sycl.sh .
RUN bash --login -c "sh install_sycl.sh"

# Setup Example Program
RUN mkdir /home/gpu-dev/example_program
COPY example_program.cpp /home/gpu-dev/example_program

WORKDIR /home/gpu-dev

RUN sudo chown -R root:root /usr/local/sycl

# Source setup_env.sh in entrypoint
ENTRYPOINT ["/bin/bash", "-c", "source /home/gpu-dev/setup_env.sh && bash -c \"sudo /sbin/sshd -D -p 2222&\" && /bin/bash", "--login", "-c"]
EXPOSE 2222
