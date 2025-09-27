data "kubernetes_server_version" "this" {}

data "helm_template" "this" {
  kube_version = data.kubernetes_server_version.this.version
  repository   = "https://helm.cilium.io"
  chart        = "cilium"
  version      = "1.18.2"
  namespace    = var.namespace
  name         = var.name
}

locals {
  deploy_files = { for file in fileset(path.module, "flux/*.yaml.tftpl") :
    basename(trimsuffix(file, ".tftpl")) => file
  }
}

resource "local_file" "flux" {
  for_each = local.deploy_files

  filename = "${var.deploy_path}/${var.name}/${each.key}"
  content = templatefile(each.value, {
    kustomize_files  = [for f, _ in local.deploy_files : f if f != "kustomization.yaml"]
    chart_repository = data.helm_template.this.repository
    chart_name       = data.helm_template.this.chart
    chart_version    = data.helm_template.this.version
    namespace        = var.namespace
    name             = var.name
    cluster_name     = var.cluster_name
    ip_pools         = var.ip_pools
    bgp              = var.bgp
  })

  directory_permission = "0755"
  file_permission      = "0644"
}
