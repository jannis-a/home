variable "name" {
  type     = string
  nullable = false
}

variable "time_zone" {
  type     = string
  nullable = false
  default  = "Europe/Berlin"
}

variable "ipv4" {
  type     = string
  nullable = false
}

variable "domain" {
  type     = string
  nullable = false
}

variable "dns" {
  type     = list(string)
  nullable = false

  validation {
    condition     = length(var.dns) == length(distinct(var.dns))
    error_message = "Duplicate entries found in dns."
  }
}