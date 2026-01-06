#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

# Demo script for EC2 execution
echo "Demo script started at $(date)"
echo "Running on host: $(hostname)"
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"

# Add your custom commands here
echo "Demo script completed successfully By Asaph!"