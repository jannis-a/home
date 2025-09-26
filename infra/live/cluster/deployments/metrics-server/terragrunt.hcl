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

terraform {
  source = "${get_repo_root()}/modules/kubernetes/metrics-server"
}

inputs = {
  deploy_path = include.cluster.locals.flux_repo_path
}
