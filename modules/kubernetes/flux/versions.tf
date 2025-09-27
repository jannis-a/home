terraform {
  required_version = ">= 1.10"

  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "~> 1.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
