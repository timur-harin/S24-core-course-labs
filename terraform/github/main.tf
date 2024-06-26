terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  token = var.token
  owner = var.user
}

resource "github_repository" "repo" {
  name        = "devops-timur-harin-terraform-lab"
  description = "Test repo for lab"
  visibility  = "public"
  has_issues  = true
  has_wiki    = true
  auto_init   = true
  has_downloads = true
  has_projects  = true
  license_template = "mit"
}

resource "github_branch_default" "main" {
  repository = github_repository.repo.name
  branch     = "main"
}

resource "github_branch_protection" "default" {
  repository_id                   = github_repository.repo.id
  pattern                         = github_branch_default.main.branch
  require_conversation_resolution = true
  enforce_admins                  = true

  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}