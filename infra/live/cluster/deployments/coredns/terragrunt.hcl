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

dependency "talos" {
  config_path = "${get_terragrunt_dir()}/../../talos/cluster"
}

terraform {
  source = "${get_repo_root()}/modules/kubernetes/coredns"
}

inputs = {
  deploy_path = include.cluster.locals.flux_repo_path
  service_ips = dependency.talos.outputs.cluster_dns
}
