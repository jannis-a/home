module "vcn" {
  source = "git::https://github.com/oracle-terraform-modules/terraform-oci-vcn//?ref=v3.6.0"

  compartment_id          = var.compartment_id
  vcn_name                = var.name
  enable_ipv6             = var.ipv6
  create_internet_gateway = var.internet_gateway
  create_service_gateway  = var.service_gateway
}

module "nsg_egress" {
  source = "../security-rule"

  compartment_id = var.compartment_id
  vcn_id         = module.vcn.vcn_id
  name           = "egress"
  egress = [
    { protocol = "all", dest = "0.0.0.0/0" },
    { protocol = "all", dest = "::/0" },
  ]
}

module "nsg_ssh" {
  source = "../security-rule"

  lifecycle {
    enabled = var.security_rules.ssh
  }

  compartment_id = var.compartment_id
  vcn_id         = module.vcn.vcn_id
  name           = "ssh"
  ingress = [
    { protocol = "tcp", ports = { to = 22 }, source = "0.0.0.0/0" },
    { protocol = "tcp", ports = { to = 22 }, source = "::/0" },
  ]
}
