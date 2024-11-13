variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "zone" {
  description = "The GCP zone"
  type        = string
}

variable "vm_count" {
  description = "Number of VM instances to create"
  type        = number
  default     = 5
}

variable "machine_type" {
  description = "The machine type for the instances"
  type        = string
  default     = "e2-medium"
}

variable "boot_disk_image" {
  description = "The boot disk image for the instances"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "boot_disk_size_gb" {
  description = "Boot disk size in GB"
  type        = number
  default     = 50
}

variable "boot_disk_type" {
  description = "Boot disk type"
  type        = string
  default     = "pd-standard"
}

variable "network_name" {
  description = "The network name to attach the VM to"
  type        = string
}

variable "subnetwork_name" {
  description = "The subnetwork name to attach the VM to"
  type        = string
}

variable "enable_public_ip" {
  description = "Whether to enable public IP"
  type        = bool
  default     = false
}

variable "additional_tags" {
  description = "Additional network tags"
  type        = list(string)
  default     = []
}

variable "service_account_email" {
  description = "Service account email"
  type        = string
}

variable "service_account_scopes" {
  description = "Service account scopes"
  type        = list(string)
  default     = ["cloud-platform"]
}
