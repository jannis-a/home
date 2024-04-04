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

resource "github_branch" "main" {
  repository = github_repository.this.name
  branch     = "main"
}

resource "github_branch_default" "this" {
  repository = github_repository.this.name
  branch     = github_branch.main.branch
}

resource "github_branch_protection" "this" {
  repository_id = github_repository.this.name
  pattern       = github_branch.main.branch

  require_signed_commits = true
}
