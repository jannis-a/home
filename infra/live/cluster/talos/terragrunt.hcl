include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/talos/cluster"
}

dependency "proxmox_1" {
  config_path = "${get_terragrunt_dir()}/../nodes/proxmox-1"
}

inputs = {
  cluster_name       = "knecht"
  talos_version      = "1.11.1"
  kubernetes_version = "1.34.1"
  nodes = {
    (dependency.proxmox_1.outputs.hostname) = {
      control_plane = true
      ip_addresses = concat(
        dependency.proxmox_1.outputs.ipv4,
        flatten(values(dependency.proxmox_1.outputs.ipv6)),
      )
    }
  }
}
