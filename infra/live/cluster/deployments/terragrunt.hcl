dependency "talos" {
  config_path = "${get_parent_terragrunt_dir("kubernetes")}/../talos"
}

generate "provide-helm" {
  path      = "_provider-helm.tf"
  if_exists = "overwrite_terragrunt"
  # language=hcl
  contents = <<-EOF
    provider "helm" {
      kubernetes = {
        host                   = "${dependency.talos.outputs.host}"
        cluster_ca_certificate = base64decode("${dependency.talos.outputs.cluster_ca_certificate}")
        client_certificate     = base64decode("${dependency.talos.outputs.client_certificate}")
        client_key             = base64decode("${dependency.talos.outputs.client_key}")
      }
    }
  EOF
}

generate "provider-kubernetes" {
  path      = "_provider-kubernetes.tf"
  if_exists = "overwrite_terragrunt"
  # language=hcl
  contents = <<-EOF
    provider "kubernetes" {
      host                   = "${dependency.talos.outputs.host}"
      cluster_ca_certificate = base64decode("${dependency.talos.outputs.cluster_ca_certificate}")
      client_certificate     = base64decode("${dependency.talos.outputs.client_certificate}")
      client_key             = base64decode("${dependency.talos.outputs.client_key}")
    }
  EOF
}
