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
    site               = string
    nameservers        = set(string)
    timeservers        = set(string)
    network = map(object({
      addresses = list(string)
      routes = list(object({
        network = string
        gateway = string
      }))
    }))
  }))
}

variable "pod_subnets" {
  type = list(string)
}

variable "service_subnets" {
  type = list(string)
}
