include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/talos/secrets"
}

inputs = {
  talos_version = "1.11.1"
}
