#!/bin/bash
set -e

# Disable IPv6 system-wide
sudo tee -a /etc/sysctl.conf > /dev/null <<EOF
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF

# Reload sysctl config
sudo sysctl -p

# Update packages using IPv4 only
sudo apt-get update -o Acquire::ForceIPv4=true -y

# Install NGINX using IPv4
sudo apt-get install -o Acquire::ForceIPv4=true -y nginx

# Start and enable NGINX service
sudo systemctl enable nginx
sudo systemctl restart nginx

# Create a default HTML file
echo "<h1>NGINX is running on Ubuntu</h1>" | sudo tee /var/www/html/index.html > /dev/null

echo "NGINX installation and configuration completed successfully."
