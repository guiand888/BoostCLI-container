# BoostCLI Docker Container

This project is a Docker container configuration for running [BoostCLI](https://github.com/valcanobacon/BoostCLI), a Python CLI program to send Boosts oer Lightning. This container also includes a secure SSH server for remote access. The project uses Docker for containerization, and instructions for Podman are also included. 

Thanks to [BoostCLI](https://github.com/valcanobacon/BoostCLI) by [valcanobacon](https://github.com/valcanobacon) for creating such a helpful tool!

## Requirements

- Docker or Podman
- docker-compose or podman-compose (for using with compose files)
- An SSH key

## How to Use

First, clone this repository:

```sh
git clone https://github.com/guiand888/BoostCLI-container
cd BoostCLI-container
```

Next, copy your SSH public key to the `config.env` file and set the other variables as necessary.

For Docker users, run the build script:

```sh
chmod +x build-docker.sh
./build.sh
```

Or for Podman users, run the podman build script:

```sh
chmod +x build-podman.sh
./build-podman.sh
```

You can then run the container using `docker-compose` or `podman-compose`:

```sh
docker-compose up --build
```

or

```sh
podman-compose up --build
```

To run the BoostCLI command directly from the client, you can SSH into the container using the following command:

```sh
ssh -p <host SSH port> <user>@<container IP or hostname> boostcli
```

Remember to replace `<host SSH port>`, `<user>`, and `<container IP or hostname>` with your actual host's SSH port, the username you have chosen, and the IP or hostname of your container. After logging in, you can execute the BoostCLI command as needed.

