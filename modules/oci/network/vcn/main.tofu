module "vcn" {
  source = "git::https://github.com/oracle-terraform-modules/terraform-oci-vcn//?ref=v3.6.0"

  compartment_id          = var.compartment_id
  vcn_name                = var.name
  enable_ipv6             = var.ipv6
  create_internet_gateway = var.internet_gateway
  create_service_gateway  = var.service_gateway
}

module "nsg_ssh" {
  source = "../security-rule"

  lifecycle {
    enabled = var.security_rules.ssh
  }

  compartment_id = var.compartment_id
  vcn_id         = module.vcn.vcn_id
  name           = "ssh"
  rules = [
    { direction = "INGRESS", protocol = "6", ports = { to = 22 }, source_type = "CIDR_BLOCK", source = "0.0.0.0/0" },
    { direction = "INGRESS", protocol = "6", ports = { to = 22 }, source_type = "CIDR_BLOCK", source = "::/0" },
  ]
}
