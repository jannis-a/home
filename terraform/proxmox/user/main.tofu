resource "proxmox_virtual_environment_user" "this" {
  user_id = "${var.name}@${var.realm}"
  groups  = var.groups
  enabled = var.enabled

  email      = var.email
  first_name = var.first_name
  last_name  = var.last_name
  comment    = var.comment

  password = var.password
  keys     = join("\n", var.ssh_keys)

  dynamic "acl" {
    for_each = var.acls
    content {
      role_id   = acl.key
      path      = acl.value.path
      propagate = acl.value.propagate
    }
  }
}

resource "proxmox_virtual_environment_user_token" "this" {
  for_each = var.tokens

  user_id               = proxmox_virtual_environment_user.this.user_id
  token_name            = each.key
  comment               = each.value.comment
  expiration_date       = each.value.expiration_date
  privileges_separation = each.value.privileges_separation
}