terraform {
  backend "gcs" {
    bucket  = "statefilepoc"
    prefix  = "state"
  }  
  required_version = ">= 0.12.7"  
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = "5.9.0"
    }
  }
}
provider "google" {
  project = "vibrant-petal-406618"
  region  = "us-central1"
  zone    = "us-central1-a"
}