include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/proxmox/vm"
}

inputs = {
  node   = "proxmox"
  name   = "homeassistant"
  cpu    = { cores = 8 }
  memory = { floating = 4096, dedicated = 8192 }
  disks  = [{ size = 64, iothread = false }]

  pci_mappings = {
    0 = "wifi"
  }

  usb_mappings = [
    "bluetooth",
    "skyconnect",
  ]
}
