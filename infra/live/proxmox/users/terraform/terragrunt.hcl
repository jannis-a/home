include {
  path = find_in_parent_folders("root.hcl")
}

include "proxmox" {
  path = find_in_parent_folders("providers/proxmox.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/proxmox/user"
}

inputs = {
  name  = "terraform"
  realm = "pve"
  acls = {
    Administrator = {}
  }
}