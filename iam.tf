// CLOUD BUILD
resource "google_project_iam_member" "cloudbuild_sa_roles" {
  project = var.project_id
  for_each = toset([
    "roles/cloudbuild.builds.builder",
    "roles/cloudbuild.workerPoolUser",
    "roles/source.reader",
    "roles/iam.serviceAccountUser",
    "roles/run.admin",
    "roles/storage.objectAdmin",
    "roles/secretmanager.secretAccessor"

  ])

  member = "serviceAccount:418744326158@cloudbuild.gserviceaccount.com"
  role   = each.key
}
resource "google_project_iam_member" "default-sa" {
  project = var.project_id
  for_each = toset([
    "roles/editor",
    "roles/secretmanager.secretAccessor"

  ])

  member = "serviceAccount:418744326158-compute@developer.gserviceaccount.com"
  role   = each.key
}

resource "google_project_iam_member" "cloud-service-api" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:418744326158@cloudservices.gserviceaccount.com"
}

resource "google_project_iam_member" "compute-engine-sa" {
  project = var.project_id
  role    = "roles/compute.serviceAgent"
  member  = "serviceAccount:service-418744326158@compute-system.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "container-sa" {
  project = var.project_id
  role    = "roles/containerregistry.ServiceAgent"
  member  = "serviceAccount:service-418744326158@containerregistry.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "artifact-sa" {
  project = var.project_id
  role    = "roles/artifactregistry.serviceAgent"
  member  = "serviceAccount:service-418744326158@gcp-sa-artifactregistry.iam.gserviceaccount.com"
}
resource "google_project_iam_member" "cloudbuild-sa-agent" {
  project = var.project_id
  role    = "roles/cloudbuild.serviceAgent"
  member  = "serviceAccount:service-418744326158@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}



resource "google_project_iam_member" "cloudrun-sa-agent" {
  project = var.project_id
  role    = "roles/run.serviceAgent"
  member  = "serviceAccount:service-418744326158@serverless-robot-prod.iam.gserviceaccount.com"
}


// terraform
resource "google_project_iam_member" "sa_terraform_build" {
  project = var.project_id
  for_each = toset([
    "roles/resourcemanager.projectIamAdmin",
    "roles/run.admin",
    "roles/storage.admin",
    "roles/secretmanager.secretAccessor",
    "roles/cloudbuild.builds.builder",
    "roles/storage.objectAdmin",
    "roles/logging.logWriter",
    "roles/editor",
    "roles/iam.roleAdmin",
    "roles/iam.serviceAccountUser",
    "roles/cloudsql.editor"
  ])

  member = "serviceAccount:${google_service_account.our_sa_terraform_build.email}"
  role   = each.key
}