# Base Image
FROM debian:unstable

# Update and install required packages
RUN apt update && apt upgrade -y && apt install -y \
    systemd \
    systemd-sysv \
    openssh-server \
    sudo \
    dbus \
    vim \
    docker.io \
    lxc \
    curl \
    git \
    && apt clean && rm -rf /var/lib/apt/lists/*

# idk
RUN curl -fOL https://github.com/coder/code-server/releases/download/v4.96.2/code-server_4.96.2_amd64.deb &&\
sudo dpkg -i code-server_4.96.2_amd64.deb
    
# Set the user as root with the custom name
USER root

# Expose the default port used by Visual Studio Code Server
EXPOSE 8080

# Set a password for authentication
ENV PASSWORD="PrivatePass123#"

# Copy any additional extensions or settings you want to include
# For example, if you have a list of extensions in a file called extensions.txt:
# COPY extensions.txt /home/coder/extensions.txt
# RUN cat /home/coder/extensions.txt | xargs -n 1 code-server --install-extension

RUN systemctl set-default multi-user.target
RUN systemctl enable docker
RUN systemctl enable code-server@root

# Set systemd as the entrypoint
CMD ["/lib/systemd/systemd"]
