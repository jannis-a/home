include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "git::https://github.com/oracle-terraform-modules/terraform-oci-vcn//?ref=v3.6.0"
}

inputs = {
  compartment_id = include.root.locals.project.compartment_id
  enable_ipv6    = true
}
