# Environment Setup

## Create `cloud-init.yaml` and SSH Key

```shell
./create_ssh_key.sh
```

## Create Ubuntu Instances

* utils instance
  ```shell
  multipass launch noble \
    --name utils \
    --mount scripts:/scripts \
    --mount ansible:/ansible \
    --mount terraform:/terraform \
    --mount demo_data:/demo_data \
    --cloud-init cloud-init.yaml
  ```

* deploy instance
  ```shell
  multipass launch noble \
    --name mysql \
    --mount scripts:/scripts \
    --cloud-init cloud-init.yaml
  ```

## Set up Utils Server

* Install tools
  ```shell
  cd /scripts
  ./001_utils_install.sh
  ./002_utils_install_sops.sh
  ```

## Set up Deploy Server

* Install MySQL server
  ```shell
  cd /scripts
  ./101_deploy_install.sh
  ```
