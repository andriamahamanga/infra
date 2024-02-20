resource "google_secret_manager_secret" "DB-PASSWORD" {
  project = var.project_id
  secret_id = "DB-PASSWORD"

  labels = {
    label = "db-password"
  }

  replication {
    user_managed {
      replicas {
        location = var.region
      }

    }
  }
}