output "talos_version" {
  value = talos_machine_secrets.this.talos_version
}

output "client_configuration" {
  value     = talos_machine_secrets.this.client_configuration
  sensitive = true
}

output "machine_secrets" {
  value     = talos_machine_secrets.this.machine_secrets
  sensitive = true
}
