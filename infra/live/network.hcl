locals {
  subnets = {
    v4 = "172.16.0.0/24"
    v6 = {
      ula = "fd11:99c6:9b95:10::/64"
      gua = "2a02:8070:6480:32f0::/64"
    }
  }

  router = {
    v4 = cidrhost(local.subnets.v4, 1)
    v6 = {
      ula = cidrhost(local.subnets.v6.ula, 1)
      gua = cidrhost(local.subnets.v6.gua, 1)
    }
  }

  nameservers = [
    local.router.v4,
    local.router.v6.ula,
  ]

  timeservers = [
    local.router.v4,
    local.router.v6.ula,
  ]
}
