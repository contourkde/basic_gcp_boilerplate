locals {
  instance_name_prefix = "vm-${var.environment}"
}

resource "google_compute_instance" "vm_instances" {
  count        = var.vm_count
  name         = "${local.instance_name_prefix}-${count.index + 1}"
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = var.boot_disk_image
      size  = var.boot_disk_size_gb
      type  = var.boot_disk_type
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name

    dynamic "access_config" {
      for_each = var.enable_public_ip ? [1] : []
      content {
        // Ephemeral public IP
      }
    }
  }

  metadata = {
    environment = var.environment
  }

  tags = concat(["${var.environment}-vm"], var.additional_tags)

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }

  lifecycle {
    create_before_destroy = true
  }
}
