# Ansible
## K3S
You need to prepare vault .yaml file with the same environment variables as in k3s/vars/main.yaml but prefixed with "vault_" e.g. "vault_k3s_token" instead of "k3s_token"