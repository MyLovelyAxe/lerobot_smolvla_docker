FROM dustynv/l4t-pytorch:r36.4.0

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

# Get your fork/branch
RUN git clone --depth 1 git@github.com:MyLovelyAxe/lerobot.git

# Install smolvla extras
WORKDIR /opt/lerobot
RUN pip install -e ".[smolvla]"

# Quick sanity check at build time (optional but helpful)
RUN python3 -c "import torch; print(torch.__version__, torch.cuda.is_available())"
