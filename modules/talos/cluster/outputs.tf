output "host" {
  value = talos_cluster_kubeconfig.this.kubernetes_client_configuration.host
}

output "cluster_ca_certificate" {
  value = talos_cluster_kubeconfig.this.kubernetes_client_configuration.ca_certificate
}

output "client_certificate" {
  value = talos_cluster_kubeconfig.this.kubernetes_client_configuration.client_certificate
}

output "client_key" {
  value     = talos_cluster_kubeconfig.this.kubernetes_client_configuration.client_key
  sensitive = true
}
