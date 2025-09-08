locals {
  proxmox_ve_endpoint  = run_cmd("--terragrunt-quiet", "op", "read", "op://Homelab/Proxmox Terraform/website")
  proxmox_ve_api_token = run_cmd("--terragrunt-quiet", "op", "read", "op://Homelab/Proxmox Terraform/token")
}

terraform {
  extra_arguments "provider_proxmox" {
    commands = get_terraform_commands_that_need_input()
    env_vars = {
      PROXMOX_VE_ENDPOINT  = local.proxmox_ve_endpoint
      PROXMOX_VE_API_TOKEN = local.proxmox_ve_api_token
      PROXMOX_VE_INSECURE  = true
    }
  }
}
