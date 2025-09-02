include {
  path = find_in_parent_folders("root.hcl")
}

include "proxmox" {
  path = find_in_parent_folders("providers/proxmox.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/proxmox/node"
}

# TODO: derive IPs, etc
inputs = {
  name   = "proxmox"
  ipv4   = "192.168.0.2"
  domain = "lan"
  dns = [
    "2a02:8070:6480:32e0::1",
    "192.168.0.1",
  ]
}