resource "helm_release" "this" {
  repository = "oci://ghcr.io/coredns/charts"
  chart      = "coredns"
  version    = "1.43.3"
  namespace  = "kube-system"
  name       = "coredns"

  set = [
    {
      name  = "replicaCount"
      value = 1
    },
    {
      name  = "serviceAccount.create"
      value = true
    },
    {
      name  = "service.clusterIP"
      value = "10.96.0.10"
    },
    {
      name  = "service.ipFamilyPolicy"
      value = "RequireDualStack"
    },
  ]
}
