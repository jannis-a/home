variable "deploy_path" {
  type = string
}

variable "name" {
  type    = string
  default = "metrics-server"
}

variable "namespace" {
  type    = string
  default = "kube-system"
}
