include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules/cloudflare/access"
}

inputs = {
  account_id = include.root.locals.cloudflare_account_id
  zone       = "jannis-assenheimer.de"
  domain     = include.root.locals.project.name

  session_duration = "336h"
  allowed_emails = [
    "jannis.assenheimer@gmail.com",
    "nweipprecht@gmail.com",
  ]
}
