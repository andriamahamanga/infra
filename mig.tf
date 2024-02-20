module "gce-container" {
  source = "github.com/terraform-google-modules/terraform-google-container-vm?ref=v3.1.1"
  # version = "2.0.0"
  container = {
    image = "test:test-latest"
  }
}
module "mig_template" {
  source               = "terraform-google-modules/vm/google//modules/instance_template"
  project_id          = var.project_id
  version              = "10.1.1"
  network              = google_compute_network.poc-vpc.self_link
  subnetwork           = google_compute_subnetwork.poc-subnetwork.self_link
  name_prefix          = "test"
  source_image_family  = "cos-stable"
  source_image_project = "cos-cloud"
  service_account = {
    email  = ""
    scopes = ["cloud-platform"]
  }
  source_image         = reverse(split("/", module.gce-container.source_image))[0]
  metadata = merge(var.additional_metadata, tomap({"gce-container-declaration" = module.gce-container.metadata_value}),
  tomap({"google-logging-enabled" = "true"}))
  machine_type = "n2-standard-4"

  tags = [
    "genycom-container-mig"
  ]
  labels = {
    "container-vm" = module.gce-container.vm_container_label
  }

}
module "mig" {
  source            = "terraform-google-modules/vm/google//modules/mig"
  project_id          = var.project_id
  version           = "10.1.1"
  instance_template = module.mig_template.self_link
  region            = var.region
  hostname          = "test"
  target_size       = var.mig_instance_count
  named_ports = [
    {
      name = "http",
      port = var.image_port
    }
  ]
  distribution_policy_zones = ["us-central1-b"]

  health_check = {
    type                = "http"
    initial_delay_sec   = 300
    check_interval_sec  = 60
    healthy_threshold   = 1
    timeout_sec         = 45
    unhealthy_threshold = 5
    response            = ""
    proxy_header        = "NONE"
    port                = 80
    request             = ""
    request_path        = "/"
    enable_logging = true
    host                = ""
  }

}