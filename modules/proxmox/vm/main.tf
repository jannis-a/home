resource "proxmox_virtual_environment_vm" "this" {
  node_name = var.node
  name      = var.name

  on_boot = true

  bios          = "ovmf"
  machine       = "q35"
  scsi_hardware = "virtio-scsi-pci"
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
      backup    = disk.value.backup
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
    type    = "virtio"
  }

  operating_system {
    type = "l26"
  }

  dynamic "hostpci" {
    for_each = var.pci_mappings
    content {
      device  = "hostpci${hostpci.key}"
      mapping = hostpci.value
    }
  }

  dynamic "usb" {
    for_each = var.usb_mappings
    content {
      mapping = usb.key
    }
  }
}
