#!/bin/bash
# =============================================================================
# Factorio Server Setup Script for GCP VM
# Run this script after SSH'ing into your GCP VM instance
# =============================================================================

set -e

echo "=== Updating system packages ==="
sudo apt update && sudo apt upgrade -y

echo "=== Installing Docker ==="
sudo apt install -y docker.io docker-compose

echo "=== Starting Docker service ==="
sudo systemctl start docker
sudo systemctl enable docker

echo "=== Adding current user to docker group ==="
sudo usermod -aG docker $USER

echo "=== Creating Factorio data directory ==="
mkdir -p ~/factorio-server/data
cd ~/factorio-server

echo "=== Setting correct permissions for Factorio container ==="
# The factoriotools/factorio container runs as UID 845
sudo chown -R 845:845 ~/factorio-server/data

echo "=== Docker version ==="
docker --version
docker-compose --version

echo ""
echo "=============================================================================
Setup complete!

Next steps:
1. Log out and back in (or run 'newgrp docker') for group changes to take effect
2. Upload your docker-compose.yml and config files to ~/factorio-server/
3. Run: cd ~/factorio-server && docker-compose up -d
4. Check logs with: docker-compose logs -f

Don't forget to create the GCP firewall rule for UDP port 34197!
============================================================================="

