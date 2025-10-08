terraform_binary = "tofu"


remote_state {
  backend = "s3"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = get_env("OCI_BUCKET")
    key    = "${path_relative_to_include()}/tfstate.json"
    endpoint = format("https://%s.compat.objectstorage.%s.oraclecloud.com",
      get_env("OCI_NAMESPACE"),
      get_env("AWS_REGION"),
    )

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
