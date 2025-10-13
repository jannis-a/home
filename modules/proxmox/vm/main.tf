resource "proxmox_virtual_environment_vm" "this" {
  node_name = var.node
  name      = var.name

  on_boot         = true
  stop_on_destroy = true

  bios          = "ovmf"
  machine       = "q35"
  scsi_hardware = "virtio-scsi-single"
  tablet_device = false

  cpu {
    type  = var.cpu.type
    cores = var.cpu.cores
  }

  memory {
    dedicated = var.memory.dedicated
    floating  = var.memory.floating
  }

  dynamic "disk" {
    for_each = var.disks
    content {
      interface = "scsi${disk.key}"
      size      = disk.value.size
      iothread  = disk.value.iothread
      replicate = disk.value.replicate
      ssd       = disk.value.ssd
      discard   = disk.value.discard
    }
  }

  network_device {
    bridge      = var.network.device
    mac_address = var.network.mac
    vlan_id     = var.network.vlan
    firewall    = var.network.firewall
  }

  efi_disk {
    file_format = "raw"
    type        = "4m"
  }

  agent {
    enabled = true
  }

  operating_system {
    type = "l26"
  }
}
