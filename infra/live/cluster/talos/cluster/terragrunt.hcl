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

dependencies {
  paths = ["../../nodes/proxmox"]
}

dependency "image" {
  config_path = "${get_terragrunt_dir()}/../image"
}

inputs = {
  cluster_name       = "knecht"
  talos_version      = include.cluster.locals.talos_version
  kubernetes_version = "1.34.1"
  installer          = dependency.image.outputs.installer
  service_subnets    = include.cluster.locals.service_subnets
  nodes = {
    talos = {
      control_plane = true
      kubelet_subnets = [
        include.network.locals.subnets.v4,
        include.network.locals.subnets.v6_ula,
      ]
    }
  }
}
