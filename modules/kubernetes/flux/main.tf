data "github_repository" "this" {
  name = var.repository
}

resource "tls_private_key" "this" {
  algorithm = "ED25519"
}

resource "github_repository_deploy_key" "this" {
  title      = var.key_name
  repository = data.github_repository.this.name
  key        = tls_private_key.this.public_key_openssh
  read_only  = false
}

resource "flux_bootstrap_git" "this" {
  depends_on = [github_repository_deploy_key.this]

  path = var.path
  kustomization_override = (var.bootstrap
    ? file("${path.module}/patches/bootstrap.yaml")
    : null
  )
}
