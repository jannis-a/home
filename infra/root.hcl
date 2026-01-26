locals {
  cloudflare_account_id = "f8ce0e89b81c568f7585d90fb5cb6744"

  project = try(read_terragrunt_config(find_in_parent_folders("project.hcl")).locals, {})
}

remote_state {
  backend = "s3"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    region = get_env("OCI_REGION")
    bucket = get_env("OCI_BUCKET")
    key    = "${path_relative_to_include()}/tfstate.json"

    encrypt      = true
    use_lockfile = true

    # S3-compatible flags
    force_path_style            = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
  }
}

generate "remote_state_encryption_config" {
  path      = "_encryption.tf"
  if_exists = "overwrite_terragrunt"
  # language=hcl
  contents = <<-HCL
    terraform {
      encryption {
        key_provider "external" "env" {
          command = ["${get_repo_root()}/scripts/tofu-key-provider.sh"]
        }
        key_provider "pbkdf2" "derived" {
          chain = key_provider.external.env
        }
        method "aes_gcm" "main" {
          keys = key_provider.pbkdf2.derived
        }
        state {
          method   = method.aes_gcm.main
          enforced = true
        }
        plan {
          method   = method.aes_gcm.main
          enforced = true
        }
      }
    }
  HCL
}
