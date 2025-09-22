locals {
  talos_version = "1.11.1"
  service_subnets = [
    "10.96.0.0/12",
    "fd11:99c6:9b95:ffff::/112", # TODO: change this?
  ]
}
