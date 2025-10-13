include {
  path = find_in_parent_folders("root.hcl")
}

include "cluster" {
  path           = find_in_parent_folders("cluster.hcl")
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "${get_repo_root()}/modules/talos/image"
}

inputs = {
  release      = include.cluster.locals.talos_version
  platform     = "metal"
  architecture = "amd64"
  extensions = [
    "siderolabs/intel-ucode",
    "siderolabs/qemu-guest-agent",
    "siderolabs/util-linux-tools",
    "siderolabs/zfs",
  ]
}
