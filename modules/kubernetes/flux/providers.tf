provider "flux" {
  kubernetes = {
    host                   = var.kubernetes.host
    cluster_ca_certificate = var.kubernetes.cluster_ca_certificate
    client_certificate     = var.kubernetes.client_certificate
    client_key             = var.kubernetes.client_key
  }
  git = {
    url = "ssh://${replace(data.github_repository.this.ssh_clone_url, ":", "/")}"
    ssh = {
      username    = split("@", data.github_repository.this.ssh_clone_url)[0]
      private_key = tls_private_key.this.private_key_pem
    }
  }
}
