include {
  path = find_in_parent_folders("root.hcl")
}

include "helm" {
  path = find_in_parent_folders("helm.hcl")
}

include "kubectl" {
  path = find_in_parent_folders("kubectl.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/kubernetes/cilium"
}

inputs = {
  asd = "invalid"
}
