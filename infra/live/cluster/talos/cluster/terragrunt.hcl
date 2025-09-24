include {
  path = find_in_parent_folders("root.hcl")
}

include "network" {
  path           = find_in_parent_folders("network.hcl")
  expose         = true
  merge_strategy = "deep"
}

include "cluster" {
  path           = find_in_parent_folders("cluster.hcl")
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "${get_repo_root()}/modules/talos/cluster"
}

dependency "image" {
  config_path = "${get_terragrunt_dir()}/../image"
}

dependency "proxmox_1" {
  config_path = "${get_terragrunt_dir()}/../../nodes/proxmox-1"
}

inputs = {
  cluster_name       = "knecht"
  talos_version      = include.cluster.locals.talos_version
  kubernetes_version = "1.34.1"
  installer          = dependency.image.outputs.installer
  service_subnets    = include.cluster.locals.service_subnets
  nodes = {
    (dependency.proxmox_1.outputs.hostname) = {
      control_plane = true
      ip_addresses = concat(
        dependency.proxmox_1.outputs.ipv4,
        flatten(values(dependency.proxmox_1.outputs.ipv6)),
      )
      dns = include.network.locals.dns
      ntp = include.network.locals.ntp
    }
  }
}
