variable "account_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "domain" {
  type = string
}

variable "session_duration" {
  type = string
}

variable "allowed_emails" {
  type = set(string)
}
