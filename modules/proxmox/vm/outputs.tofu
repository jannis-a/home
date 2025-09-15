output "id" {
  value = proxmox_virtual_environment_vm.this.id
}

output "ipv4" {
  value = [
    for ip in flatten(proxmox_virtual_environment_vm.this.ipv4_addresses) : ip
    if ip != "127.0.0.1"
  ]
}

locals {
  ipv6 = {
    addresses = flatten(proxmox_virtual_environment_vm.this.ipv6_addresses)
    regex = {
      link = "(?i)^fe[89ab][0-9a-f]:"
      ula  = "^f(c|d)[0-9a-f]{2}:"
      gua  = "^(2|3)[0-9a-f]{3}:"
    }
  }
}

output "ipv6" {
  value = {
    for type, regex in local.ipv6.regex :
    type => [for ip in local.ipv6.addresses : ip if can(regex(regex, ip))]
  }
}
