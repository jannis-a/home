data "helm_template" "this" {
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
  version    = "3.13.0"
  namespace  = var.namespace
  name       = var.name
}

resource "local_file" "flux" {
  for_each = fileset("${path.module}/flux", "*.yaml")

  filename             = "${var.deploy_path}/${var.name}/${each.key}"
  directory_permission = "0755"
  file_permission      = "0644"
  content = templatefile("flux/${each.key}", {
    chart_version = data.helm_template.this.version
    name          = var.name
    namespace     = var.namespace
  })
}
