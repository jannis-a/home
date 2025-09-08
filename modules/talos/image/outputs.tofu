output "schematic_id" {
  value = talos_image_factory_schematic.this.id
}

output "initramfs" {
  value = data.talos_image_factory_urls.this.urls.initramfs
}

output "kernel" {
  value = data.talos_image_factory_urls.this.urls.kernel
}

output "kernel_command_line" {
  value = data.talos_image_factory_urls.this.urls.kernel_command_line
}
