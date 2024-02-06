resource "google_cloudbuild_trigger" "build_trigger_terraform_feature" {
  name        = "testbuild"
  project     = vibrant-petal-406618
  provider    = google
  description = "Build trigger for terraform ci/cd  "

  trigger_template {
    project_id  = vibrant-petal-406618
    repo_name   = nodehello
    branch_name = main
  }
  included_files = ["**"]
  ignored_files  = [".gitignore"]
  build {
    step {
      id         = "tf init"
      name       = "hashicorp/terraform:1.1.9"
      entrypoint = "sh"
      args       = ["-c", "terraform init "]
    }
    step {
      id         = "tf plan"
      name       = "hashicorp/terraform:1.1.9"
      entrypoint = "sh"
      args       = ["-c", "terraform plan"]
    }

  }


}