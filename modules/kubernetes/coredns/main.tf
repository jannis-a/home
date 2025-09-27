data "helm_template" "this" {
  repository = "https://coredns.github.io/helm"
  chart      = "coredns"
  version    = "1.43.3"
  namespace  = var.namespace
  name       = var.name
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
    name             = var.name
    namespace        = var.namespace
    service_ips      = var.service_ips
  })

  directory_permission = "0755"
  file_permission      = "0644"
}
