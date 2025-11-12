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
  config_path = "../image"
}

inputs = {
  cluster_name    = include.cluster.locals.name
  pod_subnets     = include.cluster.locals.pod_subnets
  service_subnets = include.cluster.locals.service_subnets
  nodes = {
    knecht = {
      site               = "homedf"
      control_plane      = true
      talos_version      = dependency.image.outputs.version
      talos_installer    = dependency.image.outputs.installer
      kubernetes_version = "1.34.1"
      kubelet_subnets = [
        include.network.locals.subnets.v4,
        include.network.locals.subnets.v6.ula,
      ]
      nameservers = include.network.locals.nameservers
      timeservers = include.network.locals.timeservers
      network = {
        ens27u1 = {
          addresses = [for cidr in [
            include.network.locals.subnets.v4,
            include.network.locals.subnets.v6.ula,
            include.network.locals.subnets.v6.gua,
          ] : "${cidrhost(cidr, 2)}/${split("/", cidr)[1]}"]
          routes = [
            {
              network = "0.0.0.0/0"
              gateway = include.network.locals.router.v4
            },
            {
              network = "::/0"
              gateway = include.network.locals.router.v6.gua
            },
          ]
        }
      }
    }
  }
}
