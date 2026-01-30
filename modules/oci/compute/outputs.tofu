output "ips" {
  value = {
    v4 = oci_core_public_ip.this.ip_address
    v6 = oci_core_ipv6.this.ip_address
  }
}

output "docker_host" {
  value = "ssh://jannis@${oci_core_public_ip.this.ip_address}"
}
