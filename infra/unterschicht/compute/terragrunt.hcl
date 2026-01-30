include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "subnet" {
  config_path = "../subnet"
}

terraform {
  source = "${get_repo_root()}/modules/oci/compute"
}

inputs = {
  compartment_id = include.root.locals.project.compartment_id

  name      = include.root.locals.project.name
  subnet_id = dependency.subnet.outputs.id

  ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM0kmjNYmHnaCvhXAd1VX+pDEfR7zVYBQ0WaawFNKld3"
}
