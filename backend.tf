terraform {
  backend "gcs" {
    # Empty backend declaration (partial configuration : https://www.terraform.io/docs/backends/config.html#partial-configuration).
    # The properties will be provided during the initialization.
  }
}
