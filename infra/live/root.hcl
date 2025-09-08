terraform_binary = "tofu"

locals {
  oci = {
    region    = "eu-frankfurt-1"
    namespace = "frwrrd2q2s5i"
    bucket    = "jannis-assenheimer-home-tg-state"
  }
  aws_access_key        = run_cmd("--terragrunt-quiet", "op", "read", "op://Homelab/OCI S3 Terragrunt/username")
  aws_secret_access_key = run_cmd("--terragrunt-quiet", "op", "read", "op://Homelab/OCI S3 Terragrunt/password")
}

terraform {
  extra_arguments "remote_backend_auth" {
    commands = distinct(concat(
      ["force-unlock", "state"],
      get_terraform_commands_that_need_vars(),
      get_terraform_commands_that_need_input(),
      get_terraform_commands_that_need_locking(),
      get_terraform_commands_that_need_parallelism(),
    ))
    env_vars = {
      AWS_ACCESS_KEY_ID     = local.aws_access_key
      AWS_SECRET_ACCESS_KEY = local.aws_secret_access_key
    }
  }
}

remote_state {
  backend = "s3"
  config = {
    endpoint = "https://${local.oci.namespace}.compat.objectstorage.${local.oci.region}.oraclecloud.com"
    bucket   = local.oci.bucket
    region   = local.oci.region
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
