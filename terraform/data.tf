data "sops_file" "this" {
  source_file = "secrets.yaml"
}

locals {
  secret_keys = keys(data.sops_file.this.data)
}
