#!/bin/bash
set -e

# Disable IPv6 system-wide
echo 'net.ipv6.conf.all.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.default.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Update and install NGINX using IPv4
sudo apt-get update -o Acquire::ForceIPv4=true -y
sudo apt-get install -o Acquire::ForceIPv4=true -y nginx

# Start and enable NGINX
sudo systemctl enable nginx
sudo systemctl start nginx

# Optional: Add welcome page
echo "<h1>NGINX is running on Ubuntu</h1>" | sudo tee /var/www/html/index.html