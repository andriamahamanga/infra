variable "branch_name" {
  description = "The name of the repository branch (develop, master, ...)"
}

variable "feature_branch_name" {
  description = "The name of the repository branch (develop, master, ...)"
}
variable "repository_name" {
  description = "Name of the code source Repository for boutique"
  default     = "github_andriamahamanga_nodehello"
}

variable "repository_infra_name" {
  description = "Name of the code source Repository for boutique"
  default     = "github_andriamahamanga_infra"
}
variable "env" {
}
variable "vpc_network" {
}
variable "region" {
}
variable "zone" {
}
variable "size" {
}
variable "project_id" {

}
variable "subnet_main_prefix" {
  
}
variable "sql_private_ip" {
  
}
variable "db_user" {
  
}
variable "mig_name" {
  description = "The desired name to assign to the deployed managed instance group"
  type        = string
  default     = "test"
}

variable "mig_instance_count" {
  description = "The number of instances to place in the managed instance group"
  type        = string
}

variable "mig_image" {
  description = "The Docker image to deploy to GCE instances for geny.com"
  type        = string
  default     = "us-central1-docker.pkg.dev/vibrant-petal-406618/my-registre/nodes"
}

variable "image_port" {
  description = "The port the image exposes for HTTP requests"
  type        = number
  default     = 80
}

variable "service_account" {
  type = object({
    email  = string,
    scopes = list(string)
  })
  default = {
    email  = ""
    scopes = ["cloud-platform"]
  }
}

variable "additional_metadata" {
  type        = map(string)
  description = "Additional metadata to attach to the instance"
  default     = {}
}