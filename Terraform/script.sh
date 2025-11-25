#!/bin/bash

# Update system packages
sudo yum update -y

# Install Nginx (Amazon Linux 2 or Amazon Linux 2023)
sudo amazon-linux-extras install nginx1 -y 2>/dev/null || sudo yum install nginx -y

# Start Nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# Create a default webpage
echo "<h1>NGINX is running on Ubuntu (Installed via Terraform)</h1>" > /var/www/html/index.html
