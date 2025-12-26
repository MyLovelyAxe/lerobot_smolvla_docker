docker run -it --user root \
  --rm \
  --runtime nvidia \
  --gpus all \
  --net=host \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  -e HOME=/opt \
  lerobot-smolvla:r36.4.0 \
  bash -lc "python3 -c \"import torch; print('torch:', torch.__version__); print('cuda available:', torch.cuda.is_available()); print('device:', torch.cuda.get_device_name(0) if torch.cuda.is_available() else None)\"; exec bash"