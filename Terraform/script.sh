#!/bin/bash
set -e

# Update Ubuntu packages
apt-get update -y

# Install NGINX
apt-get install -y nginx

# Start and enable NGINX service
systemctl start nginx
systemctl enable nginx

# Create a default webpage
echo "<h1>NGINX is running on Ubuntu (Installed via Terraform)</h1>" > /var/www/html/index.html

