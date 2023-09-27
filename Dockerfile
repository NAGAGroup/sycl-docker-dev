FROM nvidia/cuda:12.2.0-devel-rockylinux9

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
        ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
        ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics,utility

# Setup SSH
RUN dnf install -y openssh-server rsync
RUN ssh-keygen -A
RUN echo "X11Forwarding yes" >> /etc/ssh/sshd_config

# Setup X11
RUN dnf install xorg-x11-xauth xorg-x11-fonts-* xorg-x11-utils -y
RUN dnf install mesa-dri-drivers -y

# Setup Dev Tools
RUN dnf install gdb cmake -y
RUN dnf install epel-release -y
RUN dnf install 'dnf-command(config-manager)'
RUN dnf config-manager --set-enabled crb
RUN dnf install @"Development Tools" -y
RUN dnf install jq ocl-icd cmake git ninja-build python3 gcc-toolset-12 spirv-tools-libs -y
RUN dnf install librevenge-gdb clang-tools-extra perf wget -y
RUN dnf install mpfr-devel boost-devel gmp-devel -y
RUN dnf install python3-psutil psutils perl -y

# Setup User
ARG USERNAME=sycl
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN dnf install passwd shadow-utils sudo -y

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN chpasswd $USERNAME <<< "$USERNAME:naga_is_awesome"

USER $USERNAME
WORKDIR /home/$USERNAME

# Clone Intel LLVM for SYCL
ARG DPCPP_SOURCE=/home/$USERNAME/.local/source/sycl
RUN mkdir -p $DPCPP_SOURCE 
RUN git clone https://github.com/intel/llvm -b sycl --depth=1 $DPCPP_SOURCE/llvm

# Install OneAPI OpenCL libraries for CPU and FPGA Emulation
COPY install_intel_drivers.sh /home/$USERNAME
RUN sh /home/$USERNAME/install_intel_drivers.sh
RUN if [ $? -ne 0 ]; then exit 1; fi

# Build SYCL-LLVM
COPY build_sycl.sh .
RUN sh build_sycl.sh
RUN mkdir -p /home/$USERNAME/.local/share
RUN ln -s $DPCPP_SOURCE/llvm/build /home/$USERNAME/.local/share/sycl

# Setup Example Program
RUN mkdir /home/$USERNAME/example_program
COPY example_program.cpp /home/$USERNAME/example_program

# Setup SYCL-LLVM Tests
COPY run_lit_tests.sh /home/$USERNAME

# Fix Permissions
RUN sudo chown $USERNAME build_sycl.sh
RUN sudo chown -R $USERNAME /home/$USERNAME/example_program
RUN sudo chown $USERNAME run_lit_tests.sh

# Setup bashrc
RUN export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN export LD_LIBRARY_PATH=
RUN echo "source /opt/rh/gcc-toolset-12/enable" > /home/$USERNAME/setup_env.sh
RUN echo "export TERM=xterm-256color" >> /home/$USERNAME/setup_env.sh
RUN echo "export DPCPP_SOURCE=$DPCPP_SOURCE" >> /home/$USERNAME/setup_env.sh
RUN echo "source /runtimes/oneapi-tbb/env/vars.sh" >> /home/$USERNAME/setup_env.sh
RUN echo "export PATH=/home/$USERNAME/.local/share/sycl/bin:\$PATH" >> /home/$USERNAME/setup_env.sh
RUN echo "export LD_LIBRARY_PATH=/home/$USERNAME/.local/share/sycl/lib:\$LD_LIBRARY_PATH" >> \
    /home/$USERNAME/setup_env.sh
RUN echo "source /home/$USERNAME/setup_env.sh" >> /home/$USERNAME/.bashrc

EXPOSE 2222
CMD sudo /sbin/sshd -D -p 2222
