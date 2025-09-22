locals {
  talos_version = "1.11.1"
  service_subnets = [
    "10.96.0.0/12",
    "fd11:99c6:9b95:ffff::/112", # TODO: change this?
  ]

  pod_subnets = {
    v4 = {
      cidr = "10.244.0.0/16"
      mask = 24
    }
    v6 = {
      cidr = "2a02:8070:6480:32f1:0::/68"
      mask = 80
    }
  }

  bgp = {
    name = "openwrt"
    asn  = 64512
    peers = {
      v4 = "192.168.16.1"
      v6 = "fd11:99c6:9b95:10::1"
    }
  }
}
