include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "docker" {
  path = find_in_parent_folders("docker.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/apps//traefik"
}

inputs = {
}
