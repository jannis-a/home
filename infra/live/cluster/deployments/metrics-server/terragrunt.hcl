include {
  path = find_in_parent_folders("root.hcl")
}

include "helm" {
  path = find_in_parent_folders("helm.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/kubernetes/metrics-server"
}
