# Makefile for Infrastructure Management

# Variables
ENVIRONMENT ?= dev
TERRAFORM_DIR = environments/$(ENVIRONMENT)
OPA_POLICY_DIR = policies/opa

.PHONY: init plan apply destroy validate lint security-check policy-check clean help

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: ## Initialize Terraform working directory
	cd $(TERRAFORM_DIR) && terraform init

plan: init ## Create Terraform plan
	cd $(TERRAFORM_DIR) && terraform plan -out=tfplan

apply: ## Apply Terraform plan
	cd $(TERRAFORM_DIR) && terraform apply tfplan

destroy: ## Destroy Terraform-managed infrastructure
	cd $(TERRAFORM_DIR) && terraform destroy

validate: ## Validate Terraform files
	@echo "Validating Terraform files..."
	cd $(TERRAFORM_DIR) && terraform validate
	@echo "Running terraform fmt check..."
	terraform fmt -check -recursive

lint: ## Run TFLint
	@echo "Running TFLint..."
	tflint --init
	tflint --recursive

security-check: ## Run security checks with tfsec
	@echo "Running tfsec..."
	tfsec .

policy-check: ## Run OPA policy checks
	@echo "Running OPA policy checks..."
	cd $(TERRAFORM_DIR) && \
	terraform plan -out=tfplan.binary && \
	terraform show -json tfplan.binary > tfplan.json && \
	opa eval --format pretty --data ../../$(OPA_POLICY_DIR)/compute.rego --input tfplan.json "data.terraform.compute"

clean: ## Clean up generated files
	find . -type f -name "tfplan" -delete
	find . -type f -name "tfplan.binary" -delete
	find . -type f -name "tfplan.json" -delete
	find . -type d -name ".terraform" -exec rm -rf {} +
	find . -type f -name ".terraform.lock.hcl" -delete
	find . -type f -name "*.tfstate" -delete
	find . -type f -name "*.tfstate.backup" -delete

all-checks: validate lint security-check policy-check ## Run all checks

# Development workflow
dev-init: ## Initialize development environment
	@echo "Initializing development environment..."
	make init ENVIRONMENT=dev

dev-plan: ## Create plan for development environment
	@echo "Creating plan for development environment..."
	make plan ENVIRONMENT=dev

dev-apply: ## Apply changes to development environment
	@echo "Applying changes to development environment..."
	make apply ENVIRONMENT=dev

# Production workflow
prod-init: ## Initialize production environment
	@echo "Initializing production environment..."
	make init ENVIRONMENT=prod

prod-plan: ## Create plan for production environment
	@echo "Creating plan for production environment..."
	make plan ENVIRONMENT=prod

prod-apply: ## Apply changes to production environment
	@echo "Applying changes to production environment..."
	make apply ENVIRONMENT=prod

# Default target
.DEFAULT_GOAL := help
