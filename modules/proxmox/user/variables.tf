variable "name" {
  type     = string
  nullable = false
}

variable "comment" {
  type     = string
  nullable = true
  default = null
}

variable "password" {
  type     = string
  nullable = true
  sensitive = true
  default = null
}