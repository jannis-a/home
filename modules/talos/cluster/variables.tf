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
    dns           = list(string)
    ntp           = list(string)
  }))
}

variable "virtual_ip" {
  type    = string
  default = "192.168.16.10"
}

variable "installer" {
  type = string
}

variable "service_subnets" {
  type = list(string)
}
