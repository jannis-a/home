resource "talos_machine_secrets" "this" {}

locals {
  cluster_dns = [for cidr in var.service_subnets : cidrhost(cidr, 10)]
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = [for name, conf in var.nodes : name if conf.control_plane]
  nodes                = keys(var.nodes)
}

data "talos_machine_configuration" "this" {
  for_each = var.nodes

  kubernetes_version = var.kubernetes_version
  talos_version      = var.talos_version
  cluster_name       = var.cluster_name

  cluster_endpoint = "https://${data.talos_client_configuration.this.endpoints[0]}:6443"
  machine_type     = each.value.control_plane ? "controlplane" : "worker"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
  config_patches = [
    # Base
    yamlencode({
      machine = {
        install = {
          image = var.installer
        }

        network = {
          hostname = each.key
        }

        kubelet = {
          nodeIP = {
            validSubnets = each.value.kubelet_subnets
          }
        }

        features = {
          hostDNS = {
            enabled              = true
            forwardKubeDNSToHost = false
          }
        }

        nodeLabels = {
          site = "home"
        }
      }

      cluster = {
        allowSchedulingOnControlPlanes = true
      }
    }),

    # Cilium
    yamlencode({
      machine = {
        nodeTaints = {
          "node.cilium.io/agent-not-ready" = "true:NoExecute"
        }
      }

      cluster = {
        proxy = {
          disabled = true
        }

        network = {
          cni = {
            name = "none"
          }

          podSubnets     = []
          serviceSubnets = var.service_subnets

        }
        controllerManager = {
          extraArgs = {
            allocate-node-cidrs = false
          }
        }
      }
    }),

    # CoreDNS
    yamlencode({
      machine = {
        kubelet = {
          clusterDNS = local.cluster_dns
        }
      }

      cluster = {
        coreDNS = {
          disabled = true
        }
      }
    }),
  ]
}

resource "talos_machine_configuration_apply" "this" {
  for_each = data.talos_machine_configuration.this

  node                        = each.key
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = each.value.machine_configuration
}

resource "talos_machine_bootstrap" "this" {
  depends_on           = [talos_machine_configuration_apply.this]
  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = data.talos_client_configuration.this.endpoints[0]
}

data "dns_a_record_set" "endpoints" {
  for_each = toset(data.talos_client_configuration.this.endpoints)
  host     = each.key
}

# noinspection TfUnusedElements
data "talos_cluster_health" "this" {
  depends_on = [talos_machine_bootstrap.this]

  skip_kubernetes_checks = true
  client_configuration   = talos_machine_secrets.this.client_configuration
  endpoints              = data.talos_client_configuration.this.endpoints
  control_plane_nodes    = [for e in data.dns_a_record_set.endpoints : one(e.addrs)]
}

resource "local_file" "talos_config" {
  content  = data.talos_client_configuration.this.talos_config
  filename = pathexpand("~/.talos/config")

  directory_permission = "0700"
  file_permission      = "0600"
}

resource "talos_cluster_kubeconfig" "this" {
  depends_on = [talos_machine_bootstrap.this]

  node                 = talos_machine_bootstrap.this.node
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
