resource "oci_core_network_security_group" "this" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.name
}

resource "oci_core_network_security_group_security_rule" "rule_egress_all" {
  for_each = {
    for r in var.rules :
    lower("${r.direction}_${r.protocol}_${r.source_type}_${r.source}") => r
  }

  network_security_group_id = oci_core_network_security_group.this.id

  direction   = each.value.direction
  protocol    = each.value.protocol
  source_type = each.value.source_type
  source      = each.value.source

  tcp_options {
    destination_port_range {
      min = coalesce(each.value.ports.from, each.value.ports.to)
      max = each.value.ports.to
    }
  }
}
