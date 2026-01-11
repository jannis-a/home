resource "proxmox_virtual_environment_time" "this" {
  node_name = var.name
  time_zone = var.time_zone

}

resource "proxmox_virtual_environment_hosts" "this" {
  node_name = var.name

  dynamic "entry" {
    for_each = {
      "127.0.0.1" = ["localhost.localdomain", "localhost"]
      (var.ip)    = ["${var.name}.${var.domain}", var.name]
      "::1"       = ["ip6-localhost", "ip6-loopback"]
      "fe00::0"   = ["ip6-localnet"]
      "ff00::0"   = ["ip6-mcastprefix"]
      "ff02::1"   = ["ip6-allnodes"]
      "ff02::2"   = ["ip6-allrouters"]
      "ff02::3"   = ["ip6-allhosts"]
    }

    content {
      address   = entry.key
      hostnames = entry.value
    }
  }
}
