variable "node" {
  type = string
}

variable "name" {
  type = string
}

variable "cpu" {
  type = object({
    type  = optional(string, "host")
    cores = number
  })
}

variable "memory" {
  type = object({
    floating  = number
    dedicated = number
  })
}

variable "disk" {
  type = object({
    size     = number
    iothread = optional(bool, true)
    ssd      = optional(bool, true)
    discard  = optional(string, "on")
  })
}

variable "network" {
  type = object({
    device   = string
    mac      = string
    vlan     = number
    firewall = optional(bool, true)
  })
}
