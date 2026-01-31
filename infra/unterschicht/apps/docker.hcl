dependency "vm" {
  config_path = "${dirname(find_in_parent_folders("docker.hcl"))}/../compute"
}

generate "provider-docker" {
  path      = "_provider-docker.tofu"
  if_exists = "overwrite_terragrunt"
  # language=hcl
  contents = <<-HCL
    provider "docker" {
      host = "${dependency.vm.outputs.docker_host}"
    }
  HCL
}
