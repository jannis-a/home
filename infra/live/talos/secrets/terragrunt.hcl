include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/talos/secrets"
}

inputs = {
  release = "v1.11.1"
}
