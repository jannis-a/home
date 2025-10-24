terraform_binary = "tofu"

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
        key_provider "external" "environment" {
          command = ["sh", "-c",
            <<-SH
              KEY="$(base64 <<< $TOFU_STATE_KEY)"
              printf '{"keys": {"encryption_key": "%s", "decryption_key": "%s"}}' $KEY $KEY
            SH
          ]
        }

        key_provider "pbkdf2" "this" {
          chain = key_provider.external.environment
        }

        method "aes_gcm" "this" {
          keys = key_provider.pbkdf2.this
        }

        state {
          method   = method.aes_gcm.this
          enforced = true
        }

        plan {
          method   = method.aes_gcm.this
          enforced = true
        }
      }
    }
  HCL
}
