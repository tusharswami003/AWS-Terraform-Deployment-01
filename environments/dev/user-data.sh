#!/bin/bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "=========================================="
echo "Starting DevOps Racer bootstrap"
echo "=========================================="

# Install server prerequisites
apt-get update
apt-get install -y --no-install-recommends nginx unzip awscli

# Prepare deployment directory
mkdir -p /tmp/devops-racer
rm -rf /tmp/devops-racer/*

# Download current application artifact
echo "Downloading DevOps Racer artifact..."

for attempt in {1..6}; do
    if aws s3 cp \
        s3://devops-racer/artifacts/latest.zip \
        /tmp/devops-racer/app.zip
    then
        echo "Artifact downloaded successfully"
        break
    fi

    echo "Download attempt ${attempt} failed. Retrying in 10 seconds..."
    sleep 10
done

# Do not continue if artifact was never downloaded
if [ ! -f /tmp/devops-racer/app.zip ]; then
    echo "ERROR: Unable to download application artifact"
    exit 1
fi

# Deploy application
rm -rf /var/www/html/*

unzip -o \
    /tmp/devops-racer/app.zip \
    -d /var/www/html/

chown -R www-data:www-data /var/www/html

# Validate NGINX configuration
nginx -t

# Start NGINX
systemctl enable nginx
systemctl restart nginx

echo "=========================================="
echo "DevOps Racer deployment completed"
echo "=========================================="