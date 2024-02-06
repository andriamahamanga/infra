resource "google_artifact_registry_repository" "my-registre" {
  repository_id = "my-registre"
  location = "us-central1"
  description   = "registry with terraform"
  format  = "docker"
}

resource "google_cloudbuild_trigger" "react-trigger" {
  location = "us-central1"

  trigger_template {
    branch_name = "main"
    repo_name   = "nodehello"
  }

  filename      = "./cloudbuild.yaml"
  ignored_files = [".gitignore", "terraform/*"]
  # build {
  #   step {
  #     name       = "node"
  #     entrypoint = "npm"
  #     args       = ["install"]
  #   }
  # }
}