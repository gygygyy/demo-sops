#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

# Install SOPS
ARCH="$(uname -m)"
export ARCH
case $(uname -m) in \
    i386)   architecture="386" ;; \
    i686)   architecture="386" ;; \
    x86_64) architecture="amd64" ;; \
    arm)    dpkg --print-architecture | grep -q "arm64" && architecture="arm64" || architecture="arm" ;; \
    aarch64) architecture="arm64" ;; \
esac
# Download the binary
curl -LO "https://github.com/getsops/sops/releases/download/v3.9.1/sops-v3.9.1.linux.${architecture}"
# Move the binary in to your PATH
mv "sops-v3.9.1.linux.${architecture}" "/usr/local/bin/sops"
# Make the binary executable
chmod +x "/usr/local/bin/sops"
sops --version
