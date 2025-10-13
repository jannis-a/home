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
  cluster_name    = include.cluster.locals.name
  service_subnets = include.cluster.locals.service_subnets
  nodes = {
    knecht = {
      control_plane      = true
      talos_version      = dependency.image.outputs.version
      talos_installer    = dependency.image.outputs.installer
      kubernetes_version = "1.34.1"
      kubelet_subnets = [
        include.network.locals.subnets.v4,
        include.network.locals.subnets.v6_ula,
      ]
      site = "home"
      disks = {
        openebs-local = {
          min_size = "500GB"
          device   = "/dev/sdb"
        }
      }
    }
  }
}
