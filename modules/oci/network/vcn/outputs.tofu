output "id" {
  value = module.vcn.vcn_id
}

output "security_groups" {
  value = {
    ssh = module.nsg_ssh.id
  }
}
