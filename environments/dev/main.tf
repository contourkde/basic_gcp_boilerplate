terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }

  backend "gcs" {
    # Backend configuration should be provided via backend config file
    # or command line arguments to prevent credentials exposure
  }
}

provider "google" {
  # Provider configuration will be injected via environment variables
  # or GitHub Secrets during deployment
}

module "compute" {
  source = "../../modules/compute"
  
  project_id            = var.project_id
  environment          = var.environment
  region               = var.region
  zone                 = var.zone
  vm_count             = var.vm_count
  network_name         = var.network_name
  subnetwork_name      = var.subnetwork_name
  service_account_email = var.service_account_email
  
  # Optional parameters with defaults
  enable_public_ip     = false
  additional_tags      = []
}

# Network and security modules will be implemented later
