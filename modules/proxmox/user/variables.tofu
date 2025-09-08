variable "realm" {
  type = string

  validation {
    condition     = contains(["pam", "pve"], var.realm)
    error_message = "Realm must be one of: pam, pve"
  }
}

variable "name" {
  type = string
}

variable "groups" {
  type    = set(string)
  default = []
}

variable "enabled" {
  type    = bool
  default = true
}

variable "email" {
  type    = string
  default = null
}

variable "first_name" {
  type    = string
  default = null
}

variable "last_name" {
  type    = string
  default = null
}

variable "comment" {
  type     = string
  nullable = true
  default  = null
}

variable "password" {
  type      = string
  sensitive = true
  nullable  = true
  default   = null
}

variable "acls" {
  type = map(object({
    path      = optional(string, "/")
    propagate = optional(bool, true)
  }))
  default = {}
}

variable "ssh_keys" {
  type    = set(string)
  default = []

  validation {
    condition     = alltrue([for k in var.ssh_keys : can(regex("^(?:ssh-(?:rsa|ed25519)|ecdsa-sha2-nistp(?:256|384|521)|sk-(?:ecdsa-sha2-nistp256|ssh-ed25519)@openssh\\.com)(?:-cert-v01@openssh\\.com)? [A-Za-z0-9+/]+={0,2}(?: [^\\r\\n]+)?$", k))])
    error_message = "Invalid format for item(s) in ssh_keys"
  }
}

variable "tokens" {
  type = map(object({
    comment               = optional(string, null)
    expiration_date       = optional(string, null)
    privileges_separation = optional(bool, true)
  }))
  default = {}
}
