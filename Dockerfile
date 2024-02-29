FROM ghcr.io/nagagroup/cuda-x11-docker:latest

# Copy pixi project for devenv
RUN rm -rf /home/gpu-dev/.local/share/devenv
COPY devenv /home/gpu-dev/.local/share/devenv
RUN sudo chown -R gpu-dev:gpu-dev /home/gpu-dev/.local/share/devenv
RUN echo "pixi run --manifest-path \$PIXI_PROJECT_MANIFEST install-llvm" >> /home/gpu-dev/.bashrc

# Setup Example Program
RUN mkdir example_program
COPY example_program.cpp example_program
RUN sudo chown -R gpu-dev:gpu-dev example_program

# Source setup_env.sh in entrypoint
ENTRYPOINT ["/bin/bash", "-c", "bash -c \"sudo /sbin/sshd -D -p 2222&\"; /bin/bash", "-c"]
EXPOSE 2222
