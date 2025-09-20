include {
  path = find_in_parent_folders("root.hcl")
}

include "kubernetes" {
  path = find_in_parent_folders("kubernetes.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/kubernetes/cilium"
}

inputs = {
  asd = "invalid"
}
