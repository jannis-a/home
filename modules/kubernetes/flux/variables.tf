variable "repository" {
  type = string
}

variable "branch" {
  type    = string
  default = "main"
}

variable "path" {
  type    = string
  default = "deploy"
}

variable "key_name" {
  type    = string
  default = "Flux"
}

variable "namespace" {
  type    = string
  default = "flux-system"
}

variable "sops_key" {
  type      = string
  sensitive = true
}

variable "registry_auth" {
  type = map(object({
    username = string
    password = string
  }))
  sensitive = true
  default   = {}
}

variable "kubernetes" {
  type = object({
    host                   = string
    cluster_ca_certificate = string
    client_certificate     = string
    client_key             = string
  })
  sensitive = true
}

variable "bootstrap" {
  type    = bool
  default = false
}
