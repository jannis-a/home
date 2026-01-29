variable "compartment_id" {
  type = string
}

variable "vcn_id" {
  type = string
}

variable "route_table_id" {
  type    = string
  default = null
}

variable "cidr" {
  type = object({
    v4 = string
    v6 = string
  })
}
