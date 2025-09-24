locals {
  subnets = {
    v4     = "192.168.16.0/24"
    v6_ula = "fd11:99c6:9b95:10::/64"
    v6_gua = "2a02:8070:6480:32f1::/64"
  }

  router = {
    v4     = cidrhost(local.subnets.v4, 1)
    v6_ula = cidrhost(local.subnets.v6_ula, 1)
    v6_gua = cidrhost(local.subnets.v6_gua, 1)
  }

  dns = [
    local.router.v4,
    local.router.v6_ula,
  ]

  ntp = [
    local.router.v4,
    local.router.v6_ula,
  ]
}
