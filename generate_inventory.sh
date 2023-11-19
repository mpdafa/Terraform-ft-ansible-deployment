#!/bin/bash

PRIVATE_IPS=($(terraform output private_ips))

echo "[worker_nodes]"
for ((i=0; i<${#PRIVATE_IPS[@]}; i++)); do
    echo "worker-node-${i + 1} ansible_ssh_host=${PRIVATE_IPS[i]} ansible_ssh_user=ec2-user"
done

echo -e "\n[worker_nodes:vars]"
echo "hostname_variable=WORKER_NODE_HOSTNAME"