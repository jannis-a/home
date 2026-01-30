terraform {
  required_version = ">= 1.11"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    oci = {
      source  = "oracle/oci"
      version = "~> 7.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
