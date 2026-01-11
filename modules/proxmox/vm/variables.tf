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
    ssd       = optional(bool, true)
    iothread  = optional(bool, true)
    backup    = optional(bool, true)
    replicate = optional(bool, true)
    discard   = optional(string, "on")
  }))
}

variable "network" {
  type = object({
    device   = optional(string, "vmbr0")
    mac      = optional(string, null)
    vlan     = optional(number, null)
    firewall = optional(bool, false)
  })
  default = {}
}

variable "pci_mappings" {
  type    = map(string)
  default = {}
}

variable "usb_mappings" {
  type    = set(string)
  default = []
}
