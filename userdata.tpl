#!/bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo chkconfig docker on
sudo usermod -aG docker $USER
sudo amazon-linux-extras install ansible2 -y