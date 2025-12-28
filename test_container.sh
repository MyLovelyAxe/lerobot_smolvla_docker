docker run -it --user root \
  --rm \
  --runtime nvidia \
  --gpus all \
  --net=host \
  -e HOME=/opt \
  lerobot-smolvla:pytorch2.7 \
  bash -lc "python3 -c \"import torch, torchvision; print('torch:', torch.__version__); print('torchvision:', torchvision.__version__); print('cuda available:', torch.cuda.is_available()); print('device:', torch.cuda.get_device_name(0) if torch.cuda.is_available() else None)\"; exec bash"