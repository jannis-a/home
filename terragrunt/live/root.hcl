locals {
  oci = {
    region    = "eu-frankfurt-1"
    namespace = "frwrrd2q2s5i"
    bucket    = "jannis-assenheimer-terragrunt"
  }

  secrets = yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.yaml")))
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    endpoint = "https://${local.oci.namespace}.compat.objectstorage.${local.oci.region}.oraclecloud.com"
    region   = local.oci.region
    bucket   = local.oci.bucket
    key      = "${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}/tofu.tfstate"

    # TODO: make this work and remove keys
    # profile = "DEFAULT"
    access_key = local.secrets.oci_access_key
    secret_key = local.secrets.oci_secret_key

    encrypt                     = true
    use_lockfile                = true
    force_path_style            = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
  }
}