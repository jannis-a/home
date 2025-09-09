terraform_binary = "tofu"

locals {
  oci = {
    region    = "eu-frankfurt-1"
    namespace = "frwrrd2q2s5i"
    bucket    = "jannis-assenheimer-home-tg-state"
  }
}

terraform {
  before_hook "lock_providers" {
    commands = ["init", "providers"]
    execute = concat(["tofu", "providers", "lock"], formatlist("-platform=%s", [
      "linux_amd64",
      "linux_arm64",
      "darwin_amd64",
      "darwin_arm64",
    ]))
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
