include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/proxmox/node"
}

inputs = {
  name = "proxmox"
}
