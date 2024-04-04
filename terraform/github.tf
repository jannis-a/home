resource "github_repository" "this" {
  name       = "home"
  visibility = "private"

  allow_squash_merge = true
  allow_merge_commit = true
  allow_rebase_merge = false

  delete_branch_on_merge = true
}
