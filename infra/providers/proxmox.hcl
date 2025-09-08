terraform {
  extra_arguments "provider_proxmox" {
    commands = get_terraform_commands_that_need_input()
    env_vars = {
      PROXMOX_VE_ENDPOINT  = run_cmd("--terragrunt-quiet", "op", "read", "op://Homelab/Proxmox Terraform/website")
      PROXMOX_VE_API_TOKEN = run_cmd("--terragrunt-quiet", "op", "read", "op://Homelab/Proxmox Terraform/token")
      PROXMOX_VE_INSECURE  = true
    }
  }
}
