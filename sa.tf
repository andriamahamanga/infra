resource "google_service_account" "our_sa_terraform_build" {
  account_id   = "edv4-terraform-sa-${var.env}"
  display_name = "Service Account for cloudbuild terraform edv4 ${var.env}"
}