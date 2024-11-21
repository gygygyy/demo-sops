#!/usr/bin/env bash

export SOPS_AGE_KEY_FILE="$HOME/.sops/demo-key.txt"

mkdir -p "$HOME/.sops"
age-keygen -o "${SOPS_AGE_KEY_FILE}"
