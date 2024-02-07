resource "google_cloudbuild_trigger" "react-trigger" {
  location = "us-central1"

  github {
     name  = "nodehello" 
     owner = "andriamahamanga" 

     push {
         branch       = var.branch_name
    }
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