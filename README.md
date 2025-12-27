The docker commands in this repository use `$ docker` instead of `$ sudo docker`, so make sure your USER is in groups:

```bash
sudo usermod -aG docker $USER
```

Check if your USER is already in groups by:

```bash
groups
```

If your USER is in the returned list, then move on.

Clone this repo:

```bash
git clone git@github.com:MyLovelyAxe/lerobot_smolvla_docker.git
cd lerobot_smolvla_docker
```

Build image:

```bash
./build_image.sh
```

Test a container, create then remove:
```bash
./test_container.sh
```

Create a container named `smolvla_container` and keep:

```bash
./create_container.sh
```

Restart the created container:
```bash
docker start -ai smolvla_container
```

Open other terminals into the restarted container:
```bash
docker exec -it smolvla_container bash
```

Inside the container, run smolvla:

```bash
cd /opt/lerobot/examples/tutorial/smolvla
python smolvla_zmq.py
```