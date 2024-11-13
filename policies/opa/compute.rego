package terraform.compute

import input.planned_values as tfplan

# Allowed machine types
allowed_machine_types = [
    "e2-medium",
    "e2-standard-2",
    "e2-standard-4"
]

# Deny if machine type is not in allowed list
deny[msg] {
    instance := tfplan.root_module.child_modules[_].resources[_]
    instance.type == "google_compute_instance"
    not machine_type_allowed(instance.values.machine_type)
    msg = sprintf(
        "VM instance '%v' uses unauthorized machine type '%v'. Allowed types: %v",
        [instance.values.name, instance.values.machine_type, allowed_machine_types]
    )
}

# Deny if instance name doesn't follow convention
deny[msg] {
    instance := tfplan.root_module.child_modules[_].resources[_]
    instance.type == "google_compute_instance"
    not regex.match("^vm-(dev|prod)-[0-9]+$", instance.values.name)
    msg = sprintf(
        "VM instance name '%v' doesn't follow naming convention 'vm-(dev|prod)-NUMBER'",
        [instance.values.name]
    )
}

# Warn if public IP is enabled
warn[msg] {
    instance := tfplan.root_module.child_modules[_].resources[_]
    instance.type == "google_compute_instance"
    access_config := instance.values.network_interface[_].access_config
    count(access_config) > 0
    msg = sprintf(
        "VM instance '%v' has public IP enabled. Consider if this is necessary",
        [instance.values.name]
    )
}

# Helper function to check if machine type is allowed
machine_type_allowed(machine_type) {
    allowed_machine_types[_] == machine_type
}

# Ensure required tags are present
deny[msg] {
    instance := tfplan.root_module.child_modules[_].resources[_]
    instance.type == "google_compute_instance"
    required_tags := {"environment"}
    missing_tags := required_tags - to_set(instance.values.tags)
    count(missing_tags) > 0
    msg = sprintf(
        "VM instance '%v' is missing required tags: %v",
        [instance.values.name, missing_tags]
    )
}

# Convert array to set
to_set(arr) = s {
    s := {x | x := arr[_]}
}
