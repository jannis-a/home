include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/terraform/proxmox/user"
}

inputs = {
  name = "terraform"
  type = "pve"
  acls = {
    Administrator = {}
  }
}