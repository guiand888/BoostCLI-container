# Use an official Python runtime as a parent image
FROM python:3.7-slim

# Set the working directory in the container to /app
WORKDIR /app

# Update and install SSH server
RUN apt-get update && apt-get install -y openssh-server sudo && apt-get clean

# Configure SSH for secure access
RUN mkdir /var/run/sshd
RUN echo 'Port 22' >> /etc/ssh/sshd_config
RUN echo 'PermitRootLogin no' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
RUN echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config

# User, UID and GID are passed as build arguments
ARG USER
ARG UID
ARG GID

# Create user
RUN groupadd -g ${GID} ${USER}
RUN useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USER}
RUN usermod -aG sudo ${USER}

# Add public key (passed as a build argument)
ARG SSH_PUBLIC_KEY
RUN mkdir -p /home/${USER}/.ssh
RUN echo "${SSH_PUBLIC_KEY}" >> /home/${USER}/.ssh/authorized_keys
RUN chown -R ${USER}:${USER} /home/${USER}/.ssh
RUN chmod 700 /home/${USER}/.ssh
RUN chmod 600 /home/${USER}/.ssh/authorized_keys

# Update pip
RUN pip install --upgrade pip

# Install any needed packages
RUN pip install setuptools==57.4.0
RUN pip install BoostCLI

# Expose SSH port
EXPOSE 22

# Keep the container running and start SSH server
CMD service ssh start && tail -f /dev/null

