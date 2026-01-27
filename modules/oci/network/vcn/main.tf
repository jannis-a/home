module "vcn" {
  source = "git::https://github.com/oracle-terraform-modules/terraform-oci-vcn//?ref=v3.6.0"

  compartment_id          = var.compartment_id
  vcn_name                = var.name
  enable_ipv6             = var.ipv6
  create_internet_gateway = var.internet_gateway
  create_service_gateway  = var.service_gateway
}
