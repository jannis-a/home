dependency "talos" {
  config_path = "${get_parent_terragrunt_dir("kubectl")}/../talos"
}

generate "provider-kubectl" {
  path      = "_provider-kubectl.tf"
  if_exists = "overwrite_terragrunt"
  # language=hcl
  contents = <<-EOF
    provider "kubectl" {
      host                   = "${dependency.talos.outputs.host}"
      cluster_ca_certificate = base64decode("${dependency.talos.outputs.cluster_ca_certificate}")
      client_certificate     = base64decode("${dependency.talos.outputs.client_certificate}")
      client_key             = base64decode("${dependency.talos.outputs.client_key}")
    }
  EOF
}
