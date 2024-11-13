output "vm_instance_ids" {
  description = "The IDs of the created VM instances"
  value       = module.compute.instance_ids
}

output "vm_instance_names" {
  description = "The names of the created VM instances"
  value       = module.compute.instance_names
}

output "vm_instance_internal_ips" {
  description = "The internal IPs of the created VM instances"
  value       = module.compute.instance_internal_ips
}

output "vm_instance_external_ips" {
  description = "The external IPs of the created VM instances (if enabled)"
  value       = module.compute.instance_external_ips
}
