variable "repository" {
  type = string
}

variable "branch" {
  type    = string
  default = "main"
}

variable "path" {
  type = string
}

variable "key_name" {
  type    = string
  default = "Flux"
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
