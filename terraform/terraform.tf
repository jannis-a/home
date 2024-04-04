terraform {
  required_version = ">= 1.6.2"

  backend "remote" {
    hostname     = "spacelift.io"
    organization = "jannis-a"

    workspaces {
      name = "home"
    }
  }

  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = ">= 1.10.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = ">= 1.0"
    }
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
    }
  }
}
