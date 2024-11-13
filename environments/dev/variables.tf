variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for resource deployment"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone for resource deployment"
  type        = string
  default     = "us-central1-a"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 5
}

variable "network_name" {
  description = "Name of the network"
  type        = string
  default     = "default"
}

variable "subnetwork_name" {
  description = "Name of the subnetwork"
  type        = string
  default     = "default"
}

variable "service_account_email" {
  description = "Service account email for VM instances"
  type        = string
}
