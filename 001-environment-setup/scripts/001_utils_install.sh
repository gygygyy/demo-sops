#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

apt-get update
apt-get install -y \
    curl \
    git \
    software-properties-common \
    gnupg \
    python3 \
    wget \
    age

# Install Ansible
add-apt-repository --yes --update ppa:ansible/ansible
apt-get install -y ansible

# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor | \
  tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

gpg --no-default-keyring \
  --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  --fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  tee /etc/apt/sources.list.d/hashicorp.list

apt-get update
apt-get install -y terraform
terraform --version
