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
    wget \
    && apt clean && rm -rf /var/lib/apt/lists/*

# idk
RUN wget https://github.com/ttalvitie/browservice/releases/download/v0.9.11.0/browservice-v0.9.11.0-x86_64.AppImage -O browservice
RUN mv browservice /usr/bin/browservice
RUN chmod +x /usr/bin/browservice
    
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

RUN /usr/bin/browservice --install-verdana

# Set systemd as the entrypoint
CMD ["/usr/bin/browservice --vice-opt-http-listen-addr=0.0.0.0:8080"]
