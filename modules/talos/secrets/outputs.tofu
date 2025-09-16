output "id" {
  value = talos_machine_secrets.this.id
}

output "version" {
  value = talos_machine_secrets.this.talos_version
}

output "client" {
  value     = talos_machine_secrets.this.client_configuration
  sensitive = true
}

output "machine" {
  value     = talos_machine_secrets.this.machine_secrets
  sensitive = true
}
