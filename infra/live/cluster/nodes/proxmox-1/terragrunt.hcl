include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/proxmox/vm"
}

inputs = {
  node = "proxmox"
  name = "talos-1"
  cpu = {
    cores = 16
  }
  memory = {
    floating  = 16384
    dedicated = 16384
  }
  network = {
    device = "vmbr0"
    mac    = "BC:24:11:44:8F:D9"
    vlan   = 16
  }
  disk = {
    size = 32
  }
}
