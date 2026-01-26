include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "vcn" {
  config_path = "../vcn"
}

terraform {
  source = "${get_repo_root()}/modules/oci/subnet"
}

inputs = {
  compartment_id = include.root.locals.project.compartment_id
  vcn_id         = dependency.vcn.outputs.vcn_all_attributes.id
  cidr           = {
    v4 = cidrsubnet(dependency.vcn.outputs.vcn_all_attributes.cidr_blocks[0], 8, 0)
    v6 = cidrsubnet(dependency.vcn.outputs.vcn_all_attributes.ipv6cidr_blocks[0], 8, 0)
  }
}
