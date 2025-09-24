locals {
  ipv4_mask = 24
  ipv4_cidr = "192.168.16.0/${local.ipv4_mask}"
  ipv4_gw   = cidrhost(local.ipv4_cidr, 1)

  ipv6_ula_mask = 64
  ipv6_ula_cidr = "fd11:99c6:9b95:10::/${local.ipv6_ula_mask}"
  ipv6_ula_gw   = cidrhost(local.ipv6_ula_cidr, 1)

  ipv6_gua_mask = 64
  ipv6_gua_cidr = "2a02:8070:6480:32f1::/${local.ipv6_gua_mask}"
  ipv6_gua_gw   = cidrhost(local.ipv6_gua_cidr, 1)

  dns = [local.ipv4_gw, local.ipv6_ula_gw]
  ntp = [local.ipv4_gw, local.ipv6_ula_gw]
}
