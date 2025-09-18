variable "cluster_name" {
  type = string
}

variable "talos_version" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "nodes" {
  type = map(object({
    ip_addresses  = list(string)
    control_plane = optional(bool, true)
  }))
}

variable "virtual_ip" {
  type    = string
  default = "192.168.16.10"
}

variable "platform" {
  type    = string
  default = "metal"
}

variable "schema_id" {
  type    = string
  default = "dc9cbcdee581eba1a3cb3f6ca711e94be0426e3fa9a90ae105cfc4d9f5c0ace1"
}
