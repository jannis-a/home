resource "talos_machine_secrets" "this" {
  talos_version = var.talos_version
}

locals {
  ip_cp    = flatten([for n in var.nodes : n.ip_addresses if n.control_plane])
  ip_nodes = flatten([for n in var.nodes : n.ip_addresses])
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = local.ip_cp
  nodes                = local.ip_nodes
}

data "talos_machine_configuration" "this" {
  for_each = var.nodes

  kubernetes_version = var.kubernetes_version
  talos_version      = var.talos_version
  cluster_name       = var.cluster_name

  cluster_endpoint = "https://${var.virtual_ip}:6443"
  machine_type     = each.value.control_plane ? "controlplane" : "worker"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
  config_patches = [
    yamlencode({
      machine = {
        install = {
          image = "factory.talos.dev/${var.platform}-installer/${var.schema_id}:v${var.talos_version}"
        }

        network = {
          hostname = each.key

          interfaces = [{
            deviceSelector = {
              physical = true
            }
            dhcp = true
            vip = {
              ip = var.virtual_ip
            }
          }]
        }

        kubelet = {
          nodeIP = {
            validSubnets = [for ip in each.value.ip_addresses : (strcontains(ip, ".")
              ? format("%s.0/24", join(".", slice(split(".", ip), 0, 3)))
              : format("%s::/64", join(":", slice(split(":", ip), 0, 4)))
            )]
          }
        }

        features = {
          hostDNS = {
            enabled              = true
            forwardKubeDNSToHost = false
          }
        }
      }

      cluster = {
        allowSchedulingOnControlPlanes = true
      }
    })
  ]
}

resource "talos_machine_configuration_apply" "this" {
  for_each = var.nodes

  node                        = each.value.ip_addresses[0]
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.this[each.key].machine_configuration
}

resource "talos_machine_bootstrap" "this" {
  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = local.ip_cp[0]
}

locals {
  ipv4_cp = [for ip in local.ip_cp : ip if strcontains(ip, ".")]
}

# noinspection TfUnusedElements
data "talos_cluster_health" "this" {
  depends_on = [talos_machine_bootstrap.this]

  skip_kubernetes_checks = true
  client_configuration   = talos_machine_secrets.this.client_configuration
  endpoints              = local.ipv4_cp
  control_plane_nodes    = local.ipv4_cp
}

resource "local_file" "talos_config" {
  content  = data.talos_client_configuration.this.talos_config
  filename = pathexpand("~/.talos/config")

  directory_permission = "0700"
  file_permission      = "0600"
}

resource "talos_cluster_kubeconfig" "this" {
  depends_on = [talos_machine_bootstrap.this]

  node                 = flatten([for n in var.nodes : n.ip_addresses if n.control_plane])[0]
  client_configuration = talos_machine_secrets.this.client_configuration
}

resource "terraform_data" "kube_config" {
  triggers_replace = {
    kube_config = talos_cluster_kubeconfig.this.kubeconfig_raw
  }

  provisioner "local-exec" {
    environment = {
      KUBECONFIG = pathexpand("~/.kube/config")
    }

    # language=bash
    command = <<-CMD
      mkdir -p $(dirname $KUBECONFIG)
      echo "${talos_cluster_kubeconfig.this.kubeconfig_raw}" > $KUBECONFIG
      chmod 600 $KUBECONFIG
    CMD
  }
}
