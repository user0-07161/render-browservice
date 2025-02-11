
# Base Image
FROM debian:unstable

# Update and install required packages
RUN apt update && apt upgrade -y && apt install -y \
    openssh-server \
    docker.io \
    git \
    wget

# idk
RUN wget https://github.com/ttalvitie/browservice/releases/download/v0.9.11.0/browservice-v0.9.11.0-x86_64.AppImage -O browservice.AppImage
RUN chmod +x browservice.AppImage
    
# Set the user as root with the custom name
# Expose the default port used by Visual Studio Code Server
EXPOSE 8080

# Copy any additional extensions or settings you want to include
# For example, if you have a list of extensions in a file called extensions.txt:
# COPY extensions.txt /home/coder/extensions.txt
# RUN cat /home/coder/extensions.txt | xargs -n 1 code-server --install-extension

# Set systemd as the entrypoint
CMD ["./browservice.AppImage --vice-opt-http-listen-addr=0.0.0.0:8080"]
