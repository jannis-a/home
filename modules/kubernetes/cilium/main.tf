resource "helm_release" "this" {
  repository = "https://helm.cilium.io"
  chart      = "cilium"
  version    = "1.18.2"
  namespace  = "kube-system"
  name       = "cilium"
  wait       = true

  # language=yaml
  values = [
    <<-YAML
      rollOutCiliumPods: true

      k8sServiceHost: "localhost"
      k8sServicePort: 7445
      kubeProxyReplacement: true

      # Native routing, no overlay
      routingMode: "native"
      autoDirectNodeRoutes: true

      # No SNAT in Cilium; your OpenWrt does NAT44 to the Internet
      enableIPv4Masquerade: false
      enableIPv6Masquerade: false

      ipv4:
        enabled: true
      ipv6:
        enabled: true

      # IPAM: simple (controller assigns per-node PodCIDR)
      ipam:
        mode: "multi-pool"

      bpf:
        lbExternalClusterIP: true

      bgpControlPlane:
        enabled: true

      hubble:
        relay:
          enabled: true
        ui:
          enabled: true

      gatewayAPI:
        enabled: true
        enableAlpn: true
        enableAppProtocol: true

      operator:
        replicas: 1
        rollOutPods: true

      envoy:
        rollOutPods: true

      cgroup:
        hostRoot: /sys/fs/cgroup
        autoMount:
          enabled: false

      securityContext:
        capabilities:
          ciliumAgent:
          - CHOWN
          - DAC_OVERRIDE
          - FOWNER
          - IPC_LOCK
          - KILL
          - NET_ADMIN
          - NET_RAW
          - SETGID
          - SETUID
          - SYS_ADMIN
          - SYS_RESOURCE
          cleanCiliumState:
          - NET_ADMIN
          - SYS_ADMIN
          - SYS_RESOURCE
     YAML
  ]
}

resource "time_sleep" "crd_creation" {
  depends_on = [helm_release.this]

  create_duration = "20s"
}

resource "kubectl_manifest" "pod_ip_pool" {
  depends_on = [time_sleep.crd_creation]

  yaml_body = yamlencode({
    apiVersion = "cilium.io/v2alpha1"
    kind       = "CiliumPodIPPool"
    metadata = {
      name = "default"
      labels = {
        site = "home"
      }
    }
    spec = {
      ipv4 = {
        maskSize = var.pod_subnets.v4.mask
        cidrs    = [var.pod_subnets.v4.cidr]
      }
      ipv6 = {
        maskSize = var.pod_subnets.v6.mask
        cidrs    = [var.pod_subnets.v6.cidr]
      }
    }
  })
}

resource "kubectl_manifest" "node_config" {
  depends_on = [time_sleep.crd_creation]

  yaml_body = yamlencode({
    apiVersion = "cilium.io/v2"
    kind       = "CiliumNodeConfig"
    metadata = {
      name      = "home"
      namespace = helm_release.this.namespace
      labels = {
        site = "home"
      }
    }
    spec = {
      nodeSelector = {
        matchLabels = {
          site = "home"
        }
      }
      defaults = {
        ipam-default-ip-pool = kubectl_manifest.pod_ip_pool.name
      }
    }
  })
}

resource "kubectl_manifest" "bgp_advertisement" {
  depends_on = [time_sleep.crd_creation]

  yaml_body = yamlencode({
    apiVersion = "cilium.io/v2"
    kind       = "CiliumBGPAdvertisement"
    metadata = {
      name = "default"
      labels = {
        bgp-advertise = "default"
      }
    }
    spec = {
      advertisements = [
        {
          advertisementType = "CiliumPodIPPool"
          selector = {
            matchLabels = {
              site = "home"
            }
          }
        },
        {
          advertisementType = "Service"
          selector = {
            matchLabels = {
              bgp = "true"
            }
          }
          service = {
            addresses = [
              "ClusterIP",
              "ExternalIP",
              "LoadBalancerIP",
            ]
          }
        },
      ]
    }
  })
}

resource "kubectl_manifest" "bgp_peer_config" {
  depends_on = [time_sleep.crd_creation]
  for_each   = var.bgp.peers

  yaml_body = yamlencode({
    apiVersion = "cilium.io/v2"
    kind       = "CiliumBGPPeerConfig"
    metadata = {
      name = "${var.bgp.name}-${each.key}"
    }
    spec = {
      families = [{
        afi  = "ip${each.key}"
        safi = "unicast"
        advertisements = {
          matchLabels = {
            bgp-advertise = "default"
          }
        }
      }]
    }
  })
}

resource "kubectl_manifest" "bgp_cluster_config" {
  depends_on = [time_sleep.crd_creation]

  yaml_body = yamlencode({
    apiVersion = "cilium.io/v2"
    kind       = "CiliumBGPClusterConfig"
    metadata = {
      name = "bgp-home"
    }
    spec = {
      nodeSelector = {
        matchLabels = {
          site = "home"
        }
      }
      bgpInstances = [{
        name     = "as-64513"
        localASN = 64513
        peers = [for protocol, address in var.bgp.peers : {
          name        = "${var.bgp.name}-${protocol}"
          peerASN     = var.bgp.asn
          peerAddress = address
          peerConfigRef = {
            name = kubectl_manifest.bgp_peer_config[protocol].name
          }
        }]
      }]
    }
  })
}
