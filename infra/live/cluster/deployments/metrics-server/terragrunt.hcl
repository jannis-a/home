include {
  path = find_in_parent_folders("root.hcl")
}

include "helm" {
  path = find_in_parent_folders("helm.hcl")
}

dependency "flux" {
  config_path = "${get_terragrunt_dir()}/../flux"
}

terraform {
  source = "${get_repo_root()}/modules/kubernetes/metrics-server"
}

inputs = {
  deploy_path = "${get_repo_root()}/${dependency.flux.outputs.deploy_path}"
}
