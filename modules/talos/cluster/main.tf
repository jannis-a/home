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

  cluster_name       = var.cluster_name
  talos_version      = each.value.talos_version
  kubernetes_version = each.value.kubernetes_version

  cluster_endpoint = "https://${data.talos_client_configuration.this.endpoints[0]}:6443"
  machine_type     = each.value.control_plane ? "controlplane" : "worker"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
  config_patches = [
    # Base
    yamlencode({
      machine = {
        install = {
          image = each.value.talos_installer
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

resource "terraform_data" "install_cilium" {
  depends_on = [
    data.talos_cluster_health.this,
    terraform_data.kube_config,
  ]

  provisioner "local-exec" {
    command = <<-CMD
      helm repo add --force-update cilium https://helm.cilium.io
      helm install cilium cilium/cilium -n kube-system \
        --set cluster.name=${var.cluster_name} \
        --set kubeProxyReplacement=true \
        --set k8sServiceHost=localhost \
        --set k8sServicePort=7445 \
        --set bgpControlPlane.enabled=true \
        --set operator.replicas=1 \
        --set securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}" \
        --set securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}" \
        --set cgroup.autoMount.enabled=false \
        --set cgroup.hostRoot=/sys/fs/cgroup
    CMD
  }
}

resource "terraform_data" "install_coredns" {
  depends_on = [terraform_data.install_cilium]

  provisioner "local-exec" {
    command = <<-CMD
      helm repo add --force-update coredns https://coredns.github.io/helm
      helm install coredns coredns/coredns -n kube-system \
        --set service.ipFamilyPolicy=PreferDualStack \
        --set service.clusterIP=${local.cluster_dns[0]} \
        --set service.clusterIPs="{${join(",", local.cluster_dns)}}"
    CMD
  }
}
