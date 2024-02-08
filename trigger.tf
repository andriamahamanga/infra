resource "google_cloudbuild_trigger" "react-trigger" {
  location = "us-central1"
  name        = "triggera"
  description = "Build trigger for terraform ci/cd  "

  trigger_template {
    repo_name   = "github_andriamahamanga_nodehello"
    branch_name = "main"
  }
  filename = "cloudbuild.yaml"
  ignored_files = [".gitignore", "terraform/*"]
  included_files = ["**"]
}


resource "google_cloudbuild_trigger" "build_trigger_terraform_feature" {
  location = "us-central1"
  name        = "testbuild"
  description = "Build trigger for terraform ci/cd  "

  trigger_template {
    repo_name   = var.repository_name
    branch_name = var.branch_name
  }
    build {

    step {
      id         = "tf init"
      name       = "hashicorp/terraform:1.1.9"
      entrypoint = "sh"
      args       = ["-c", "terraform init  "]
    }

    step {
      id         = "tf plan"
      name       = "hashicorp/terraform:1.1.9"
      entrypoint = "sh"
      args       = ["-c", "terraform plan"]
    }
  }

}