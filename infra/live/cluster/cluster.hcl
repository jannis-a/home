locals {
  name          = "knecht"
  talos_version = "1.11.2"
  service_subnets = [
    "10.96.0.0/12",
    "fd11:99c6:9b95:ffff::/112", # TODO: change this?
  ]

  ip_pools = {
    home = {
      v4 = {
        cidr = "10.244.0.0/16"
        mask = 24
      }
      v6 = {
        cidr = "2a02:8070:6480:32f1:0::/68"
        mask = 80
      }
    }
  }

  bgp = {
    openwrt = {
      site = "home"
      asn  = 64512
      peers = {
        v4 = "192.168.16.1"
        v6 = "fd11:99c6:9b95:10::1"
      }
    }
  }

  flux_path      = "deploy"
  flux_repo_path = "${get_repo_root()}/${local.flux_path}"
}
