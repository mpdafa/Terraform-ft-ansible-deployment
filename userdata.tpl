#!/bin/bash
sudo yum update -y
# sudo yum install -y docker
# sudo service docker start
# sudo chkconfig docker on
# sudo usermod -aG docker $USER
sudo amazon-linux-extras install ansible2 -y
sudo yum install -y ansible git

# Clone your GitHub repository
git clone https://github.com/mpdafa/terraform-ft-ansible-deployment /tmp/terraform-ft-ansible-deployment-repo

# Change to the ansible_project directory
cd /tmp/terraform-ft-ansible-deployment-repo/ansible_project

# Generate inventory.ini
bash /tmp/terraform-ft-ansible-deployment-repo/generate_inventory.sh > /tmp/terraform-ft-ansible-deployment-repo/ansible_project/inventory.ini

# Deploy Playbook
ansible-playbook /tmp/terraform-ft-ansible-deployment-repo/ansible_project/deploy_static_web.yml -i /tmp/terraform-ft-ansible-deployment-repo/ansible_project/inventory.ini
