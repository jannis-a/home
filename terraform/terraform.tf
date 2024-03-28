terraform {
  required_version = ">= 1.7.5"

  cloud {
    organization = "jannis-a"

    workspaces {
      name = "home"
    }
  }


  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = ">= 1.0"
    }
  }
}
