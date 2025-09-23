resource "helm_release" "this" {
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
  version    = "3.13.0"
  namespace  = "kube-system"
  name       = "metrics-server"

  set_list = [{
    name  = "args"
    value = ["--kubelet-insecure-tls"]
  }]
}
