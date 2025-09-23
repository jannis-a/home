include {
  path = find_in_parent_folders("root.hcl")
}

dependency "talos" {
  config_path = "${get_terragrunt_dir()}/../../talos/cluster"
}

terraform {
  source = "${get_repo_root()}/modules/kubernetes/flux"
}

inputs = {
  repository = "home"
  kubernetes = {
    host                   = dependency.talos.outputs.host
    cluster_ca_certificate = base64decode(dependency.talos.outputs.cluster_ca_certificate)
    client_certificate     = base64decode(dependency.talos.outputs.client_certificate)
    client_key             = base64decode(dependency.talos.outputs.client_key)
  }
}
