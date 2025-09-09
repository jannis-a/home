terraform_binary = "tofu"

locals {
  oci = {
    region    = "eu-frankfurt-1"
    namespace = "frwrrd2q2s5i"
    bucket    = "jannis-assenheimer-home-tg-state"
  }
}

terraform {
  extra_arguments "read_secrets" {
    env_vars = yamldecode(run_cmd("--terragrunt-quiet", "op", "inject", "-i", "${get_repo_root()}/.env.yaml"))
    commands = distinct(concat(
      ["force-unlock", "state"],
      get_terraform_commands_that_need_vars(),
      get_terraform_commands_that_need_input(),
      get_terraform_commands_that_need_locking(),
      get_terraform_commands_that_need_parallelism(),
    ))
  }
}

remote_state {
  backend = "s3"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    region   = local.oci.region
    bucket   = local.oci.bucket
    endpoint = "https://${local.oci.namespace}.compat.objectstorage.${local.oci.region}.oraclecloud.com"
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
