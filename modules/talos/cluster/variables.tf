variable "cluster_name" {
  type = string
}
variable "nodes" {
  type = map(object({
    control_plane      = bool
    talos_version      = string
    talos_installer    = string
    kubernetes_version = string
    kubelet_subnets    = list(string)
  }))
}

variable "service_subnets" {
  type = list(string)
}
