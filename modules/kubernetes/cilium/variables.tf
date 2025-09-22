variable "pod_subnets" {
  type = object({
    v4 = object({
      cidr = string
      mask = number
    })
    v6 = object({
      cidr = string
      mask = number
    })
  })
}

variable "bgp" {
  type = object({
    name = string
    asn  = number
    peers = object({
      v4 = string
      v6 = string
    })
  })
}
