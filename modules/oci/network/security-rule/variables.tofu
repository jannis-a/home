variable "compartment_id" {
  type = string
}

variable "vcn_id" {
  type = string
}

variable "name" {
  type = string
}

variable "egress" {
  type = list(object({
    protocol  = string
    dest_type = optional(string, "CIDR_BLOCK")
    dest      = string
  }))
  default = []
}

variable "ingress" {
  type = list(object({
    protocol    = string
    source_type = optional(string, "CIDR_BLOCK")
    source      = string
    ports = object({
      from = optional(number, null)
      to   = number
    })
  }))
  default = []
}
