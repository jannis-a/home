resource "proxmox_virtual_environment_user" "this" {
  user_id  = "${var.name}@pve"
  comment  = var.comment
  password  = var.password
}
