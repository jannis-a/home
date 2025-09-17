include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/proxmox/vm"
}

inputs = {
  node = "proxmox"
  name = "talos"
  cpu = {
    cores = 1
  }
  memory = {
    floating  = 0
    dedicated = 2048
  }
  network = {
    vlan = 16
  }
  disk = {
    size = 32
  }
}
