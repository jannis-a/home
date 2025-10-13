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

variable "disks" {
  type = list(object({
    size      = number
    iothread  = optional(bool, true)
    ssd       = optional(bool, true)
    replicate = optional(bool, false)
    discard   = optional(string, "on")
  }))
}

variable "network" {
  type = object({
    device   = string
    mac      = string
    vlan     = number
    firewall = optional(bool, true)
  })
}
