locals {
  name          = "knecht"
  talos_version = "1.11.3"
  pod_subnets = [
    "172.18.0.0/16",
    "2a02:8070:6480:32f1::/64",
  ]
  service_subnets = [
    "172.17.0.0/16",
    "fd5d:feeb:a195::/64",
  ]
}
