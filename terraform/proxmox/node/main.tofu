resource "proxmox_virtual_environment_time" "this" {
  node_name = var.name
  time_zone = var.time_zone
}

locals {
  hosts = {
    "127.0.0.1" = ["localhost.localdomain", "localhost"]
    "::1"       = ["ip6-localhost", "ip6-loopback"]
    "fe00::0"   = ["ip6-localnet"]
    "ff00::0"   = ["ip6-mcastprefix"]
    "ff02::1"   = ["ip6-allnodes"]
    "ff02::2"   = ["ip6-allrouters"]
    "ff02::3"   = ["ip6-allhosts"]
  }
}

resource "proxmox_virtual_environment_hosts" "this" {
  node_name = var.name

  entry {
    address   = var.ipv4
    hostnames = [var.name]
  }

  dynamic "entry" {
    for_each = local.hosts

    content {
      address   = entry.key
      hostnames = entry.value
    }
  }
}

resource "proxmox_virtual_environment_dns" "this" {
  node_name = var.name
  domain    = var.domain
  servers   = var.dns
}