resource "google_compute_network" "poc-vpc" {
  name = var.vpc_network
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "poc-subnetwork" {
  ip_cidr_range = var.subnet_main_prefix
  name = "poc-subnetwork-${var.env}"
  network = google_compute_network.poc-vpc.self_link
  region = var.region
}