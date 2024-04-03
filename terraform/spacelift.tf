data "spacelift_current_stack" "this" {}

resource "spacelift_environment_variable" "secrets" {
  count = length(local.secret_keys)

  stack_id   = data.spacelift_current_stack.this.id
  name       = local.secret_keys[count.index]
  value      = data.sops_file.this.data[local.secret_keys[count.index]]
  write_only = true
}
