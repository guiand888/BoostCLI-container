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
ARG MY_USER
ARG USER_ID
ARG GROUP_ID

# Create user
RUN groupadd -g ${GROUP_ID} ${MY_USER}
RUN useradd -m -s /bin/bash -u ${USER_ID} -g ${GROUP_ID} ${MY_USER}
#RUN usermod -aG sudo ${MY_USER}

# Add public key (passed as a build argument)
ARG SSH_PUBLIC_KEY
RUN mkdir -p /home/${MY_USER}/.ssh
RUN echo "${SSH_PUBLIC_KEY}" >> /home/${MY_USER}/.ssh/authorized_keys
RUN chown -R ${MY_USER}:${MY_USER} /home/${MY_USER}/.ssh
RUN chmod 700 /home/${MY_USER}/.ssh
RUN chmod 600 /home/${MY_USER}/.ssh/authorized_keys

# Update pip
RUN pip install --upgrade pip

# Install any needed packages
RUN pip install setuptools==57.4.0
RUN pip install BoostCLI

# Expose SSH port
EXPOSE 22

# Keep the container running and start SSH server
CMD service ssh start && tail -f /dev/null

