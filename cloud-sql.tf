# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE CLOUD SQL ON THE SERVICE PROJECT
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_global_address" "private_ip_address" {

  provider = google-beta

  project       = var.project_id
  name          = "test-${var.env}-sql-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24 // service 'servicenetworking.googleapis.com' requires at least one allocated range to have minimal
  // size; please make sure at least one allocated range will have prefix length smaller or equal to 24.
  network = google_compute_network.poc-vpc.self_link
  address = var.sql_private_ip
}

# needs servicenetworking API, see project.tf
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.poc-vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    "${google_compute_global_address.private_ip_address.name}"

  ]
}
resource "random_id" "db_name_suffix" {
  byte_length = 4
}
resource "google_sql_database_instance" "poc-web-pg" {

  project          = var.project_id
  region           = var.region
  name             = "poc-${var.env}-postgres-instance-${random_id.db_name_suffix.hex}"
  database_version = "POSTGRES_9_6"
  deletion_protection = false

  depends_on = [

    google_service_networking_connection.private_vpc_connection
  ]

  settings {
    tier = var.env == "prod" ? "db-custom-4-15360" : "db-custom-2-7680"
    edition                     = "ENTERPRISE"
    ip_configuration {
      ipv4_enabled    = true
      private_network = google_compute_network.poc-vpc.self_link
      authorized_networks {
          name = "my-p"
          value ="154.126.11.170"
      }

    }


    availability_type = var.env == "prod" ? "REGIONAL" : "ZONAL"

    disk_type       = "PD_SSD"
    disk_autoresize = true
    disk_size       = 50 #GB

    location_preference {
      zone = var.zone
    }
    backup_configuration {
      enabled    = true
      start_time = "00:00"    // backup at midnight (GMT)
      location   = var.region // Custom Location for backups => BACKUP REGION
    }
    maintenance_window {
      day = 4
      hour = 3
      update_track = "stable"
    }

}
}
resource "google_sql_database" "database" {
  project = var.project_id
  name     = "baseko"
  instance = google_sql_database_instance.poc-web-pg.name
}

data "google_secret_manager_secret_version" "db-password" {
  project = var.project_id
  provider = google-beta
  secret  = "DB-PASSWORD"
  depends_on = [
    google_secret_manager_secret.DB-PASSWORD
  ]
}
resource "google_sql_user" "admin-mysql" {
  name     = "admin"
  project = var.project_id
  instance = google_sql_database_instance.poc-web-pg.name
  password = data.google_secret_manager_secret_version.db-password.secret_data

  depends_on = [

    google_sql_database_instance.poc-web-pg,
    google_secret_manager_secret.DB-PASSWORD
  ]

}