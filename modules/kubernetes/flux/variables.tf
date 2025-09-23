variable "repository" {
  type = string
}

variable "path" {
  type    = string
  default = "deploy"
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
