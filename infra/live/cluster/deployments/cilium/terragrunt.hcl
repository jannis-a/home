include {
  path = find_in_parent_folders("root.hcl")
}

include "helm" {
  path = find_in_parent_folders("helm.hcl")
}

include "kubectl" {
  path = find_in_parent_folders("kubectl.hcl")
}

include "cluster" {
  path           = find_in_parent_folders("cluster.hcl")
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "${get_repo_root()}/modules/kubernetes/cilium"
}

inputs = {
  pod_subnets = include.cluster.locals.pod_subnets
  bgp         = include.cluster.locals.bgp
}
