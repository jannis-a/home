variable "compartment_id" {
  type = string
}

variable "vcn_id" {
  type = string
}

variable "name" {
  type = string
}

variable "rules" {
  type = list(object({
    direction   = string
    protocol    = string
    source_type = string
    source      = string
    ports = object({
      from = optional(number, null)
      to   = number
    })
  }))
}
