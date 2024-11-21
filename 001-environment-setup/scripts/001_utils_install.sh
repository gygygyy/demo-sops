#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

# 安裝套件
apt-get update
apt-get install -y \
    curl \
    git \
    software-properties-common \
    gnupg \
    python3 \
    wget \
    age

# 安裝 Ansible 及需使用的 Python 套件
add-apt-repository --yes --update ppa:ansible/ansible
apt-get install -y \
  ansible \
  python3-pymysql

# 安裝 Terraform
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

systemctl daemon-reload
