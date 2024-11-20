#!/usr/bin/env bash

echo "Generating cloud-init.yaml"
cat <<EOF > cloud-init.yaml
users:
  - default
  - name: ubuntu
    sudo: ALL=(ALL) NOPASSWD:ALL
    home: /home/ubuntu
    ssh: /bin/bash
    ssh_authorized_keys:
      - ./ssh_keys/multipass-ssh-key.pub
EOF

echo ""
echo "Generating multipass ssh keys..."
ssh-keygen -C ubuntu -f ssh_keys/multipass-ssh-key -P "" -q

