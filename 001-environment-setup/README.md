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
    --cloud-init cloud-init.yaml
  ```

* deploy instance
  ```shell
  multipass launch noble \
    --name deploy \
    --mount scripts:/scripts \
    --cloud-init cloud-init.yaml
  ```
