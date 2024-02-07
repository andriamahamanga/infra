resource "google_artifact_registry_repository" "my-registre" {
  repository_id = "my-registre"
  location = "us-central1"
  description   = "registry with terraform"
  format  = "docker"
}
