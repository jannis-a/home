data "helm_template" "this" {
  repository = "https://coredns.github.io/helm"
  chart      = "coredns"
  version    = "1.43.3"
  namespace  = var.namespace
  name       = var.name
}

resource "local_file" "flux" {
  for_each = fileset("${path.module}/flux", "*.yaml")

  filename             = "${var.deploy_path}/${var.name}/${each.key}"
  directory_permission = "0755"
  file_permission      = "0644"
  content = templatefile("flux/${each.key}", {
    chart_repository = data.helm_template.this.repository
    chart_name       = data.helm_template.this.chart
    chart_version    = data.helm_template.this.version
    name             = var.name
    namespace        = var.namespace
    service_ips      = var.service_ips
  })
}
