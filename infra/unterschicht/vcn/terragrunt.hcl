include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules/oci/network//vcn"
}

inputs = {
  compartment_id = include.root.locals.project.compartment_id
  name           = include.root.locals.project.name

  security_rules = {
    ssh = true
  }
}
