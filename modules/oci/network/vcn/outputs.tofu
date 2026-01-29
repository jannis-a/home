output "id" {
  value = module.vcn.vcn_id
}

output "security_groups" {
  value = {
    ssh = module.nsg_ssh.id
  }
}

output "cidr" {
  value = {
    v4 = module.vcn.vcn_all_attributes["cidr_blocks"]
    v6 = module.vcn.vcn_all_attributes["ipv6cidr_blocks"]
  }
}
