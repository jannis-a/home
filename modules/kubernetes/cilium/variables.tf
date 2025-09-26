variable "deploy_path" {
  type = string
}

variable "name" {
  type    = string
  default = "cilium"
}

variable "namespace" {
  type    = string
  default = "kube-system"
}

variable "ip_pools" {
  type = map(object({
    v4 = object({
      cidr = string
      mask = number
    })
    v6 = object({
      cidr = string
      mask = number
    })
  }))
}

variable "bgp" {
  type = map(object({
    site = string
    asn  = number
    peers = object({
      v4 = string
      v6 = string
    })
  }))
}
