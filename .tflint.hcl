plugin "google" {
    enabled = true
    version = "0.23.1"
    source  = "github.com/terraform-linters/tflint-ruleset-google"
}

config {
    module = true
    force = false
}

rule "terraform_deprecated_index" {
    enabled = true
}

rule "terraform_unused_declarations" {
    enabled = true
}

rule "terraform_documented_variables" {
    enabled = true
}

rule "terraform_documented_outputs" {
    enabled = true
}

rule "terraform_typed_variables" {
    enabled = true
}

rule "terraform_naming_convention" {
    enabled = true
    format  = "snake_case"
}

rule "terraform_required_version" {
    enabled = true
}

rule "terraform_required_providers" {
    enabled = true
}

rule "terraform_standard_module_structure" {
    enabled = true
}

# GCP specific rules
rule "google_compute_instance_invalid_machine_type" {
    enabled = true
}

rule "google_compute_instance_invalid_zone" {
    enabled = true
}

rule "google_compute_instance_invalid_boot_disk_type" {
    enabled = true
}
