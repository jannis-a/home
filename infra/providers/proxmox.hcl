locals {
  secrets = yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.yaml")))
}

generate "provider_proxmox" {
  path      = "_provider-proxmox.tofu"
  if_exists = "overwrite_terragrunt"
  # language=hcl
  contents = <<-EOT
    provider "proxmox" {
      endpoint  = "${local.secrets.proxmox_endpoint}"
      insecure  = "${local.secrets.proxmox_insecure}"
      api_token = "${local.secrets.proxmox_token_id}=${local.secrets.proxmox_secret}"
    }
  EOT
}