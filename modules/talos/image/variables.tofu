variable "release" {
  type = string
}

variable "platform" {
  type = string
}

variable "architecture" {
  type = string
}

variable "extensions" {
  type    = set(string)
  default = []
}
