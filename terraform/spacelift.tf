data "spacelift_current_stack" "this" {}

locals {
  spacelift = {
    context_name = "home"
  }
}

resource "spacelift_context" "this" {
  name   = local.spacelift.context_name
  labels = ["autoattach:${local.spacelift.context_name}"]
}

resource "spacelift_environment_variable" "secrets" {
  count = length(local.secret_keys)

  stack_id   = local.spacelift.context_name
  name       = local.secret_keys[count.index]
  value      = data.sops_file.this.data[local.secret_keys[count.index]]
  write_only = true
}
