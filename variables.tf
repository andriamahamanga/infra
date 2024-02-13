variable "branch_name" {
  description = "The name of the repository branch (develop, master, ...)"
  default     = "main"
}

variable "feature_branch_name" {
  description = "The name of the repository branch (develop, master, ...)"
  default     = "github_andriamahamanga_infra"
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
variable "project_id" {

}