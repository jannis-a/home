output "id" {
  value = proxmox_virtual_environment_user.this.id
}

output "tokens" {
  value     = { for _, token in proxmox_virtual_environment_user_token.this : token.id => token.value }
  sensitive = true
}