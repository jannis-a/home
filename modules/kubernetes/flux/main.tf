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

resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace
  }

  lifecycle {
    ignore_changes = [metadata.0.labels]
  }
}

resource "kubernetes_secret" "sops" {
  metadata {
    name      = "sops-age"
    namespace = var.namespace
  }

  data = {
    "age.agekey" = var.sops_key
  }
}

resource "kubernetes_secret" "registry_auth" {
  metadata {
    name      = "registry-auth"
    namespace = var.namespace
  }

  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = { for registry, auth in var.registry_auth : registry => {
        username = auth.username
        password = auth.password
        auth     = base64encode("${auth.username}:${auth.password}")
      } }
    })
  }
}

resource "flux_bootstrap_git" "this" {
  depends_on = [github_repository_deploy_key.this]

  path      = var.path
  namespace = var.namespace

  kustomization_override = templatefile("${path.module}/templates/kustomization.yaml.tftpl", {
    sops_secret   = kubernetes_secret.sops.metadata[0].name
    registry_auth = kubernetes_secret.registry_auth.metadata[0].name
    bootstrap     = var.bootstrap
  })
}
