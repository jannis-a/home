terraform {
  required_version = ">= 1.10"

  required_providers {
    dns = {
      source  = "hashicorp/dns"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "~> 0.10"
    }
  }
}
