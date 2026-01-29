include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "vcn" {
  config_path = "../vcn"
}

terraform {
  source = "${get_repo_root()}/modules/oci/network//subnet"
}

inputs = {
  compartment_id = include.root.locals.project.compartment_id
  vcn_id         = dependency.vcn.outputs.id
  cidr           = {
    v4 = cidrsubnet(dependency.vcn.outputs.cidr.v4[0], 8, 0)
    v6 = cidrsubnet(dependency.vcn.outputs.cidr.v6[0], 8, 0)
  }
}
