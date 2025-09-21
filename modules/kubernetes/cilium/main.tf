resource "helm_release" "this" {
  repository = "https://helm.cilium.io"
  chart      = "cilium"
  version    = "1.18.2"
  namespace  = "kube-system"
  name       = "cilium"
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

resource "kubernetes_manifest" "pod_ip_pool" {
  manifest = {
    apiVersion = "cilium.io/v2alpha1"
    kind       = "CiliumPodIPPool"
    metadata = {
      name = "home"
      labels = {
        site = "home"
      }
    }
    spec = {
      ipv4 = {
        maskSize = 24
        cidrs    = ["10.244.0.0/16"]
      }
      ipv6 = {
        maskSize = 80
        cidrs    = ["2a02:8070:6480:32f1:0::/68"]
      }
    }
  }
}

resource "kubernetes_manifest" "node_config" {
  manifest = {
    apiVersion = "cilium.io/v2"
    kind       = "CiliumNodeConfig"
    metadata = {
      name      = "home-defaults"
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
        ipam-default-ip-pool = kubernetes_manifest.pod_ip_pool.manifest.metadata.name
      }
    }
  }
}

resource "kubernetes_manifest" "bgp_advertisement" {
  manifest = {
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
              pool = "home"
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
  }
}

resource "kubernetes_manifest" "bgp_peer_config" {
  manifest = {
    apiVersion = "cilium.io/v2"
    kind       = "CiliumBGPPeerConfig"
    metadata = {
      name = "openwrt"
    }
    spec = {
      families = [for version in [4, 6] : {
        afi  = "ipv${version}"
        safi = "unicast"
        advertisements = {
          matchLabels = {
            bgp-advertise = "default"
          }
        }
      }]
    }
  }
}

resource "kubernetes_manifest" "bgp_cluster_config" {
  manifest = {
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
        peers = [
          {
            name        = "openwrt-v4"
            peerASN     = 64512
            peerAddress = "192.168.16.1"
            peerConfigRef = {
              name = kubernetes_manifest.bgp_peer_config.manifest.metadata.name
            }
          },
          {
            name        = "openwrt-v6"
            peerASN     = 64512
            peerAddress = "fd11:99c6:9b95:10::1"
            peerConfigRef = {
              name = kubernetes_manifest.bgp_peer_config.manifest.metadata.name
            }
          }
        ]
      }]
    }
  }
}
