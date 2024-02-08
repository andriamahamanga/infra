resource "google_cloudbuild_trigger" "react-trigger" {
  location = "us-central1"
  name        = "triggera"
  description = "Build trigger for terraform ci/cd  "

  trigger_template {
    repo_name   = var.repository_name
    branch_name = var.branch_name
  }
  filename = "cloudbuild.yaml"
  ignored_files = [".gitignore", "terraform/*"]
  included_files = ["**"]
}


resource "google_cloudbuild_trigger" "build_trigger_terraform_feature" {
  location = "us-central1"
  name        = "terraform-plan"
  description = "Build trigger for terraform ci/cd  "

  trigger_template {
    repo_name   = var.repository_infra_name
    branch_name = var.feature_branch_name
  }
    build {

    step {
      id         = "tf init"
      name       = "hashicorp/terraform:1.1.9"
      entrypoint = "sh"
      args       = ["-c", "terraform init -backend=true -backend-config=config-${var.env}/backend.tfvars "]
    }

    step {
      id         = "tf plan"
      name       = "hashicorp/terraform:1.1.9"
      entrypoint = "sh"
      args       = ["-c", "terraform plan var-file=config-${var.env}/terraform.tfvars"]
    }
  }

}


resource "google_cloudbuild_trigger" "build_trigger_terraform_feature" {
  location = "us-central1"
  name        = "testbuild"
  description = "Build trigger for terraform ci/cd  "

  trigger_template {
    repo_name   = var.repository_infra_name
    branch_name = var.branch_name
  }
    build {

    step {
      id         = "tf init"
      name       = "hashicorp/terraform:1.1.9"
      entrypoint = "sh"
      args       = ["-c", "terraform init  -backend=true -backend-config=config-${var.env}/backend.tfvars"]
    }

    step {
      id         = "tf plan"
      name       = "hashicorp/terraform:1.1.9"
      entrypoint = "sh"
      args       = ["-c", "terraform plan var-file=config-${var.env}/terraform.tfvars"]
    }
  }

}