include "root" {
  path = find_in_parent_folders("root.hcl")
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
  route_table_id = dependency.vcn.outputs.ig_route_id
  cidr           = {
    for proto, cidrs in dependency.vcn.outputs.cidr :
    proto => cidrsubnet(cidrs[0], 8, 0)
  }
}
