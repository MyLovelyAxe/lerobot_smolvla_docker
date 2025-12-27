docker run -it --user root \
  --name smolvla_container \
  --runtime nvidia \
  --gpus all \
  --net=host \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  -e HOME=/opt \
  lerobot-smolvla:r36.4.0 \
  bash