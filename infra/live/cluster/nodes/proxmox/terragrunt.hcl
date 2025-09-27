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
    cores = 16
  }
  memory = {
    floating  = 20 * 1024
    dedicated = 20 * 1024
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
