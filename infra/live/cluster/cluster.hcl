locals {
  name          = "unterschicht"
  talos_version = "1.11.3"
  service_subnets = [
    "172.17.0.0/16",
    "fd5d:feeb:a195::/64",
  ]
}
