
variable "compartment_id" {
  type = string
}
variable "name" {
  type = string
}

variable "ipv6" {
  type    = bool
  default = true
}

variable "internet_gateway" {
  type    = bool
  default = true
}

variable "service_gateway" {
  type    = bool
  default = true
}

variable "security_rules" {
  type = object({
    ssh = bool
  })
}
