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
    control_plane   = bool
    kubelet_subnets = list(string)
  }))
}

variable "installer" {
  type = string
}

variable "service_subnets" {
  type = list(string)
}
