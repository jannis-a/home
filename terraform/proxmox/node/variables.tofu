variable "name" {
  type = string
}

variable "time_zone" {
  type    = string
  default = "Europe/Berlin"
}

variable "ipv4" {
  type = string
}

variable "domain" {
  type = string
}

variable "dns" {
  type = list(string)

  validation {
    condition     = length(var.dns) == length(distinct(var.dns))
    error_message = "Duplicate entries found in dns."
  }
}