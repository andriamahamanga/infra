


variable "ip_cidr_range_vpc_connector_serverless" {
  description = "ip cidr range pour le vpc serverless access connector pc-access-connector"
}

variable "branch_name" {
  description = "The name of the repository branch (develop, master, ...)"
}

variable "feature_branch_name" {
  description = "The name of the repository branch (develop, master, ...)"
}
variable "db_user" {
  description = "user cloud sql "
}

variable "repository_name" {
  description = "Name of the code source Repository for boutique"
  default     = "nodehello"
}

