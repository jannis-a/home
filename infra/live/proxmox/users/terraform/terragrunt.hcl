include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/proxmox/user"
}

inputs = {
  name  = "terraform"
  realm = "pve"
  acls = {
    Administrator = {}
  }
}
