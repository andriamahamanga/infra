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
variable "project_id" {

}
variable "subnet_main_prefix" {
  
}