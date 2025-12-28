docker run -it --user root \
  --name smolvla_pytorch27_container \
  --runtime nvidia \
  --gpus all \
  --net=host \
  -v ~/lerobot:/opt/lerobot \
  -w /opt/lerobot \
  -v ~/.cache:/opt/.cache \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  -e HOME=/opt \
  lerobot-smolvla:pytorch2.7 \
  bash

# arguments:
#
#   --name smolvla_container: give the container a fixed name
#   --runtime nvidia: enable GPU access inside containers
#   --gpus all: Expose all available GPUs to the container
#   --net=host: share host network stack for ROS2, ZeroMQ, localhost comms
#   -v ~/lerobot:/opt/lerobot: mount lerobot source code from host into container
#                              host:   ~/lerobot
#                              container: /opt/lerobot
#                              this allows to edit code outside containers but the update is seen by container
#   -w /opt/lerobot: set working directory inside the container, directly enter /opt/lerobot in the container
#   -v ~/.cache:/opt/.cache: mount cache directory for later downloaded pre-trained weights
#                            host: ~/.cache
#                            container: /opt/.cache  (because HOME=/opt)
#   -v /tmp/.X11-unix:/tmp/.X11-unix: enable X11 forwarding for GUI applications
#   -e DISPLAY=$DISPLAY: pass DISPLAY variable so GUI apps know where to render
#   -e HOME=/opt: set HOME directory inside container
#   lerobot-smolvla:pytorch2.7: the image to run
#   bash: start an interactive bash shell