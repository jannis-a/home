resource "oci_core_subnet" "this" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id

  route_table_id = var.route_table_id
  cidr_block     = var.cidr.v4
  ipv6cidr_block = var.cidr.v6

  prohibit_public_ip_on_vnic = false
  prohibit_internet_ingress  = false
}
