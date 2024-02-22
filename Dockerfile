FROM ghcr.io/nagagroup/cuda-x11-docker:12.3.1

# Clone Intel LLVM for SYCL
ARG BUILD_WORKSPACE=/tmp/sycl-workspace
RUN mkdir -p $BUILD_WORKSPACE 
WORKDIR $BUILD_WORKSPACE
RUN git clone --depth=1 https://github.com/AdaptiveCpp/AdaptiveCpp $BUILD_WORKSPACE/src

# Environment setup
RUN echo "export LD_LIBRARY_PATH=\$CONDA_PREFIX/lib:/usr/local/acpp/lib:/usr/local/acpp/lib64:\$LD_LIBRARY_PATH" > /home/gpu-dev/setup_env.sh
RUN echo "export PATH=/usr/local/acpp/bin:\$PATH" >> /home/gpu-dev/setup_env.sh
RUN echo "source /home/gpu-dev/setup_env.sh" >> /home/gpu-dev/.bashrc

# Install build tools
COPY install_build_tools.sh .
RUN bash --login -c "sh install_build_tools.sh"


# Build AdaptiveCpp
COPY configure.sh .
RUN bash --login -c "sh configure.sh"
COPY build_sycl.sh .
RUN bash --login -c "sh build_sycl.sh"
COPY install_sycl.sh .
RUN bash --login -c "sh install_sycl.sh"

# Setup Example Program
RUN mkdir $HOME/example_program
COPY example_program.cpp $HOME/example_program

WORKDIR /home/gpu-dev

# Source setup_env.sh in entrypoint
ENTRYPOINT ["/bin/bash", "-c", "source /home/gpu-dev/setup_env.sh && bash -c \"sudo /sbin/sshd -D -p 2222&\" && /bin/bash", "--login", "-c"]
EXPOSE 2222
