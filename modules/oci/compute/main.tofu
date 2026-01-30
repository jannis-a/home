data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

data "oci_core_images" "this" {
  compartment_id           = var.compartment_id
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04"
  shape                    = "VM.Standard.A1.Flex"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

resource "oci_core_instance" "vm" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_id
  display_name        = var.name

  shape = "VM.Standard.A1.Flex"

  shape_config {
    ocpus         = 4
    memory_in_gbs = 24
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.this.images[0].id

    boot_volume_size_in_gbs = 200
  }

  create_vnic_details {
    subnet_id = var.subnet_id
    nsg_ids = [
      "ocid1.networksecuritygroup.oc1.eu-frankfurt-1.aaaaaaaad6aurpdfqv6y2mltvlvo2igkogd7jsr5pdhz6ztbll5xlghntckq",
      "ocid1.networksecuritygroup.oc1.eu-frankfurt-1.aaaaaaaarubdiv6y7tbfaun6kifakybqpvpitf2nreohlkrqle7xl36lutua",
    ]

    # IMPORTANT: enable IPv6 allocation on the VNIC (subnet must be IPv6-enabled)
    assign_ipv6ip = true

    # We'll attach a RESERVED public IP after creation (stable), so keep this false.
    assign_public_ip = true
  }

  instance_options {
    are_legacy_imds_endpoints_disabled = true
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}
