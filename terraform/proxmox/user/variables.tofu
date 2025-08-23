variable "name" {
  type     = string
  nullable = false
}

variable "first_name" {
  type    = string
  default = null
}

variable "last_name" {
  type    = string
  default = null
}

variable "email" {
  type    = string
  default = null
}

variable "comment" {
  type     = string
  nullable = true
  default  = null
}

variable "enabled" {
  type     = bool
  nullable = false
  default  = true
}

variable "acls" {
  type = map(object({
    path      = optional(string, "/")
    propagate = optional(bool, true)
  }))
  nullable = false
  default  = {}
}

variable "groups" {
  type     = set(string)
  nullable = false
  default  = []
}

variable "keys" {
  type     = set(string)
  nullable = false
  default  = []
}

variable "password" {
  type      = string
  nullable  = true
  sensitive = true
  default   = null
}

variable "type" {
  type     = string
  nullable = false

  validation {
    condition     = contains(["pam", "pve"], var.type)
    error_message = "Type must be one of: pam, pve"
  }
}

variable "tokens" {
  type = map(object({
    comment               = optional(string, null)
    expiration_date       = optional(string, null)
    privileges_separation = optional(bool, true)
  }))
  nullable = false
  default  = {}
}