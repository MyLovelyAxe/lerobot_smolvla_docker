# Docker for Lerobot SmolVLA on Jetson

This repository provides the docker configuration for [Lerobot SmolVLA](https://github.com/huggingface/lerobot) deployed in docker container on [Jetson Orin Nano](https://developer.nvidia.com/embedded/learn/get-started-jetson-orin-nano-devkit#intro).

## Table of Contents

- [Requirements](#requirements)
- [About](#about)
- [Docker](#docker)
- [Build](#build)
- [Usage](#usage)

---

## Requirements

- Jetson Orin Nano [8GB developer kit version]
- Jetpack 6.2.1
- Docker

---

## About

The Dockerfile and bash files in this repo build the images and containers for a [fork Lerobot SmolVLA](https://github.com/MyLovelyAxe/lerobot) deployed on Jetson Orin Nano.

The container has the following features:

- has access to GPU on Jetson Orin Nano
- exchange message with ROS2 in the host on Jetson via ZMQ socket
- mounts the lerobot repo in the host on Jetson for runtime execution
- has access to display on Jetson

> Attention:
> This repository is built for project perception-action pipeline with SmolVLA and Isaac Sim, where the SmolVLA runs on Jetson Orin Nano,the observations and actions are exchanged between Jetson container and Isaac Sim on another host machine via ROS2 humble. Therefore the script to start SmolVLA needs Isaac Sim from another host machine to provide input observations via ROS2. Check repo [isaacsim_vla_ws](https://github.com/MyLovelyAxe/isaacsim_vla_ws) for details. 

---

## Docker

This repository should base on a Jetson with prepared Docker. The tested Docker in this repo was installed via [Nvidia SDK Manager](https://www.jetson-ai-lab.com/tutorials/initial-setup-sdk-manager/#0%EF%B8%8F%E2%83%A3-install-sdk-manager), i.e. Jetson Runtime Components.

When docker is ready, make sure your `$USER` is in groups, since all the docker commands in this repository use `$ docker` instead of `$ sudo docker`:

```bash
sudo usermod -aG docker $USER
```

Check if your USER is already in groups by:

```bash
groups
```

If your `$USER` is in the returned list, then move on.

---

## Build

Clone this repo:

```bash
git clone git@github.com:MyLovelyAxe/lerobot_smolvla_docker.git
cd lerobot_smolvla_docker
```

Build a image named `lerobot-smolvla:pytorch2.7`:

```bash
./build_image.sh
```

Test a container, create then remove:
```bash
./test_container.sh
```

Create a container named `smolvla_pytorch27_container` and keep:

```bash
./create_container.sh
```

---

## Usage

Restart the created container:
```bash
docker start -ai smolvla_pytorch27_container
```

Open other terminals into the restarted container:
```bash
docker exec -it smolvla_pytorch27_container bash
```

Inside the container, run smolvla:

```bash
cd /opt/lerobot/examples/tutorial/smolvla
python smolvla_zmq.py
```