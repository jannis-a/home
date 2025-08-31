terraform_binary = "tofu"

locals {
  secrets = yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.yaml")))

  oci = {
    access_key = run_cmd("--terragrunt-quiet", "op", "read", "op://Home Lab/OCI S3 Terragrunt/username")
    secret_key = run_cmd("--terragrunt-quiet", "op", "read", "op://Home Lab/OCI S3 Terragrunt/password")

    region    = "eu-frankfurt-1"
    namespace = "frwrrd2q2s5i"
    bucket    = "jannis-assenheimer-home-tg-state"
  }
}

generate "backend" {
  path      = "_backend.tofu"
  if_exists = "overwrite_terragrunt"
  # language=hcl
  contents = <<-EOT
    terraform {
      backend "s3" {
        access_key = "${local.oci.access_key}"
        secret_key = "${local.oci.secret_key}"

        endpoint = "https://${local.oci.namespace}.compat.objectstorage.${local.oci.region}.oraclecloud.com"
        bucket   = "${local.oci.bucket}"
        region   = "${local.oci.region}"
        key      = "${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}/tofu.tfstate"

        encrypt      = true
        use_lockfile = true

        # S3-compatible flags
        use_path_style              = true
        skip_credentials_validation = true
        skip_metadata_api_check     = true
        skip_region_validation      = true
        skip_requesting_account_id  = true
      }
    }
  EOT
}

generate "provider_proxmox" {
  disable   = !strcontains(get_terragrunt_dir(), "/proxmox")
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