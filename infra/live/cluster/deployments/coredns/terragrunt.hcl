include {
  path = find_in_parent_folders("root.hcl")
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
  service_ips = dependency.talos.outputs.cluster_dns
}
