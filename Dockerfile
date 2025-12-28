FROM dustynv/pytorch:2.7-r36.4.0

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /opt

# System deps that commonly matter for robotics + video + OpenCV
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ffmpeg \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
 && rm -rf /var/lib/apt/lists/*

# Upgrade pip tooling
RUN python3 -m pip install --upgrade pip setuptools wheel

# Fix the torch/torchvision already in the base image
RUN python3 - <<'PY'
import torch, torchvision
from pathlib import Path
Path("/tmp/constraints.txt").write_text(
    f"torch=={torch.__version__}\n"
    f"torchvision=={torchvision.__version__}\n"
)
print(open("/tmp/constraints.txt").read())
PY

# Get fork lerobot repo
RUN git clone --depth 1 https://github.com/MyLovelyAxe/lerobot.git
WORKDIR /opt/lerobot

# Install lerobot + smolvla deps
RUN pip install -e ".[smolvla]" --no-build-isolation \
    -i https://pypi.org/simple \
    --extra-index-url https://pypi.ngc.nvidia.com \
    --extra-index-url http://jetson.webredirect.org/jp6/cu126 \
    -c /tmp/constraints.txt

# Downgrade numpy to 1.x, since pip automatically chose numpy 2.2.6 for lerobot, but some packages from base image require 1.x version
RUN pip install numpy==1.26.4 -i https://pypi.org/simple

# quickly test the versions
RUN python3 -c "import torch, torchvision; \
print('torch:', torch.__version__); \
print('torchvision:', torchvision.__version__); \
print('cuda available:', torch.cuda.is_available())"
