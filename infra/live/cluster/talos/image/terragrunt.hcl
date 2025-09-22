include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/talos/image"
}

inputs = {
  release      = "1.11.1"
  platform     = "metal"
  architecture = "amd64"
  extensions = [
    "siderolabs/intel-ucode",
    "siderolabs/qemu-guest-agent",
    "siderolabs/util-linux-tools",
  ]
}
