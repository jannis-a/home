resource "github_repository" "this" {
  name       = "home"
  visibility = "public"

  has_discussions = false
  has_downloads   = false
  has_issues      = false
  has_projects    = false
  has_wiki        = false

  allow_squash_merge  = true
  allow_merge_commit  = false
  allow_rebase_merge  = false
  allow_update_branch = true

  delete_branch_on_merge      = true
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
}
