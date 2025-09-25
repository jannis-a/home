variable "deploy_path" {
  type = string
}

variable "name" {
  type    = string
  default = "coredns"
}

variable "namespace" {
  type    = string
  default = "kube-system"
}

variable "service_ips" {
  type = list(string)
}
