resource "github_repository" "home" {
  name = "home"

  allow_merge_commit = false
  allow_rebase_merge = false
}
resource "github_actions_secret" "this" {
  count = length(local.secret_keys)

  repository      = github_repository.home.id
  secret_name     = local.secret_keys[count.index]
  plaintext_value = data.sops_file.this.data[local.secret_keys[count.index]]
}
