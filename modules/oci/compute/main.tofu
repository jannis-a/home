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

data "oci_core_subnet" "this" {
  subnet_id = var.subnet_id
}

resource "tls_private_key" "ssh" {
  algorithm   = "ED25519"
  ecdsa_curve = "P521"
}

resource "github_user_ssh_key" "this" {
  title = var.name
  key   = tls_private_key.ssh.public_key_openssh
}

resource "oci_core_instance" "this" {
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
    boot_volume_vpus_per_gb = 120
  }

  create_vnic_details {
    subnet_id = var.subnet_id
    nsg_ids = [
      "ocid1.networksecuritygroup.oc1.eu-frankfurt-1.aaaaaaaad6aurpdfqv6y2mltvlvo2igkogd7jsr5pdhz6ztbll5xlghntckq",
      "ocid1.networksecuritygroup.oc1.eu-frankfurt-1.aaaaaaaarubdiv6y7tbfaun6kifakybqpvpitf2nreohlkrqle7xl36lutua",
    ]

    assign_public_ip = false
    assign_ipv6ip    = false
  }

  instance_options {
    are_legacy_imds_endpoints_disabled = true
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    # language=yaml
    user_data = base64encode(<<-EOF
      #cloud-config
      package_update: true
      packages:
        - zsh
        - zsh-autosuggestions
        - zsh-syntax-highlighting
        - git
        - yadm
        - podman
      users:
        - name: jannis
          groups:
            - sudo
          shell: /bin/zsh
          sudo:
            - ALL=(ALL) NOPASSWD:ALL
          ssh_authorized_keys:
            - ${var.ssh_public_key}
      write_files:
        - path: /home/jannis/.ssh/id_${lower(tls_private_key.ssh.algorithm)}
          owner: root:root
          permissions: "0600"
          content: |
            ${indent(6, tls_private_key.ssh.private_key_openssh)}
        - path: /home/jannis/.ssh/id_${lower(tls_private_key.ssh.algorithm)}.pub
          owner: root:root
          permissions: "0600"
          content: |
            ${indent(6, tls_private_key.ssh.public_key_openssh)}
      runcmd:
        - mkdir -p /home/jannis/.ssh
        - chown -R jannis:jannis /home/jannis
        - systemctl enable --now podman.socket
        - loginctl enable-linger jannis
        - curl -fsSL https://starship.rs/install.sh | sh -s -- -y
        - sudo -u jannis -i systemctl --user enable --now podman.socket
        - sudo -u jannis -i ssh-keyscan github.com >> /home/jannis/.ssh/known_hosts
        - sudo -u jannis -i yadm clone --recurse-submodules git@github.com:jannis-a/dotfiles.git
        - sudo -u jannis -i yadm submodule update --init --recursive
      EOF
    )
  }
}

data "oci_core_vnic_attachments" "this" {
  compartment_id = var.compartment_id
  instance_id    = oci_core_instance.this.id
}

data "oci_core_private_ips" "this" {
  vnic_id = data.oci_core_vnic_attachments.this.vnic_attachments[0].vnic_id
}

resource "oci_core_public_ip" "this" {
  compartment_id = var.compartment_id
  lifetime       = "RESERVED"
  display_name   = "${var.name}-ipv4"
  private_ip_id  = data.oci_core_private_ips.this.private_ips[0].id
}

resource "oci_core_ipv6" "this" {
  vnic_id      = data.oci_core_vnic_attachments.this.vnic_attachments[0].vnic_id
  ip_address   = cidrhost(data.oci_core_subnet.this.ipv6cidr_block, 10)
  display_name = "${var.name}-ipv6"
}
