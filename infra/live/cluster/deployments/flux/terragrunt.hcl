include {
  path = find_in_parent_folders("root.hcl")
}

include "cluster" {
  path           = find_in_parent_folders("cluster.hcl")
  expose         = true
  merge_strategy = "deep"
}

include "kubernetes" {
  path = find_in_parent_folders("kubernetes.hcl")
}

dependency "talos" {
  config_path = "${get_terragrunt_dir()}/../../talos/cluster"
}

terraform {
  source = "${get_repo_root()}/modules/kubernetes/flux"
}

inputs = {
  repository = "home"
  path       = include.cluster.locals.flux_path
  kubernetes = {
    host                   = dependency.talos.outputs.host
    cluster_ca_certificate = base64decode(dependency.talos.outputs.cluster_ca_certificate)
    client_certificate     = base64decode(dependency.talos.outputs.client_certificate)
    client_key             = base64decode(dependency.talos.outputs.client_key)
  }
}
