variable "compartment_id" {
  type = string
}

variable "vcn_id" {
  type = string
}

variable "cidr" {
  type = object({
    v4 = string
    v6 = string
  })
}
