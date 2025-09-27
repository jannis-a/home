include {
  path = find_in_parent_folders("root.hcl")
}

include "cluster" {
  path           = find_in_parent_folders("cluster.hcl")
  expose         = true
  merge_strategy = "deep"
}

include "helm" {
  path = find_in_parent_folders("helm.hcl")
}

include "kubernetes" {
  path = find_in_parent_folders("kubernetes.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/kubernetes/cilium"
}

inputs = {
  deploy_path  = include.cluster.locals.flux_repo_path
  cluster_name = include.cluster.locals.name
  ip_pools     = include.cluster.locals.ip_pools
  bgp          = include.cluster.locals.bgp
}
