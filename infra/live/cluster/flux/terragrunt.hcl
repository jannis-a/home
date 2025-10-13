include {
  path = find_in_parent_folders("root.hcl")
}

include "cluster" {
  path           = find_in_parent_folders("cluster.hcl")
  expose         = true
  merge_strategy = "deep"
}

dependency "talos" {
  config_path = "../talos/cluster"
}

terraform {
  source = "${get_repo_root()}/modules/kubernetes/flux"
}

locals {
  secrets = yamldecode(sops_decrypt_file("secrets.yaml"))
}

inputs = {
  repository    = "home"
  path          = include.cluster.locals.flux_path
  sops_key      = local.secrets["sops_agekey"]
  registry_auth = local.secrets["registry_auth"]
  bootstrap     = true
  kubernetes = {
    host                   = dependency.talos.outputs.host
    cluster_ca_certificate = base64decode(dependency.talos.outputs.cluster_ca_certificate)
    client_certificate     = base64decode(dependency.talos.outputs.client_certificate)
    client_key             = base64decode(dependency.talos.outputs.client_key)
  }
}
