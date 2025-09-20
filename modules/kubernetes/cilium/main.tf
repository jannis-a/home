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
      # Tell Cilium what's natively routable (no SNAT there)
      ipv4NativeRoutingCIDR: "10.244.0.0/16"

      # IPv4 only for now
      ipv4:
        enabled: true
      ipv6:
        enabled: false

      # IPAM: simple (controller assigns per-node PodCIDR)
      ipam:
        mode: "kubernetes"
      bpf:
        lbExternalClusterIP: true
      k8s:
        requireIPv4PodCIDR: true

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
          advertisementType = "PodCIDR"
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
      families = [{
        afi  = "ipv4"
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
        peers = [{
          name        = "openwrt"
          peerASN     = 64512
          peerAddress = "192.168.16.1"
          peerConfigRef = {
            name = kubernetes_manifest.bgp_peer_config.manifest.metadata.name
          }
        }]
      }]
    }
  }
}
