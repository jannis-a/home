resource "oci_core_network_security_group" "this" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.name
}

locals {
  protocols = {
    all = "all"
    tcp = "6"
  }
}

resource "oci_core_network_security_group_security_rule" "egress" {
  for_each = {
    for r in var.egress :
    lower("${r.protocol}_${r.dest_type}_${r.dest}") => r
  }

  network_security_group_id = oci_core_network_security_group.this.id

  direction   = "EGRESS"
  protocol    = each.value.protocol
  destination_type = each.value.dest_type
  destination      = each.value.dest
}

resource "oci_core_network_security_group_security_rule" "ingress" {
  for_each = {
    for r in var.ingress :
    lower("${r.protocol}_${r.source_type}_${r.source}") => r
  }

  network_security_group_id = oci_core_network_security_group.this.id

  direction   = "INGRESS"
  protocol    = local.protocols[lower(each.value.protocol)]
  source_type = each.value.source_type
  source      = each.value.source

  tcp_options {
    destination_port_range {
      min = coalesce(each.value.ports.from, each.value.ports.to)
      max = each.value.ports.to
    }
  }
}
