output "instance_ids" {
  description = "The IDs of the created VM instances"
  value       = google_compute_instance.vm_instances[*].id
}

output "instance_names" {
  description = "The names of the created VM instances"
  value       = google_compute_instance.vm_instances[*].name
}

output "instance_self_links" {
  description = "The self-links of the created VM instances"
  value       = google_compute_instance.vm_instances[*].self_link
}

output "instance_internal_ips" {
  description = "The internal IPs of the created VM instances"
  value       = [for instance in google_compute_instance.vm_instances : instance.network_interface[0].network_ip]
}

output "instance_external_ips" {
  description = "The external IPs of the created VM instances (if enabled)"
  value       = [for instance in google_compute_instance.vm_instances : try(instance.network_interface[0].access_config[0].nat_ip, null)]
}
