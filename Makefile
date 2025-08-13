# Makefile for Terraform AWS GitHub OIDC Provider

# Variables
EXAMPLE ?= complete
EXAMPLE_DIR = examples/$(EXAMPLE)
TERRAFORM_CMD = terraform

# Find tfvars file (look for fixtures.*.tfvars or fixtures.tfvars)
TFVARS_FILE = $(shell find $(EXAMPLE_DIR) -name "fixtures*.tfvars" | head -1 | xargs basename)

# Targets
.PHONY: init plan apply destroy help

help:
	@echo "Usage: make <target> [EXAMPLE=<example_name>]"
	@echo ""
	@echo "Targets:"
	@echo "  init     - Initialize Terraform"
	@echo "  plan     - Plan Terraform deployment"
	@echo "  apply    - Apply Terraform configuration"
	@echo "  destroy  - Destroy Terraform infrastructure"
	@echo ""
	@echo "Available examples:"
	@ls examples/ 2>/dev/null || echo "  (no examples found)"

init:
	@echo "Initializing Terraform in $(EXAMPLE_DIR)..."
	cd $(EXAMPLE_DIR) && $(TERRAFORM_CMD) init

plan:
	@echo "Planning Terraform deployment for $(EXAMPLE) with $(TFVARS_FILE)..."
	cd $(EXAMPLE_DIR) && $(TERRAFORM_CMD) plan -var-file=$(TFVARS_FILE)

apply:
	@echo "Applying Terraform configuration for $(EXAMPLE) with $(TFVARS_FILE)..."
	cd $(EXAMPLE_DIR) && $(TERRAFORM_CMD) apply -var-file=$(TFVARS_FILE)

destroy:
	@echo "Destroying Terraform infrastructure for $(EXAMPLE) with $(TFVARS_FILE)..."
	cd $(EXAMPLE_DIR) && $(TERRAFORM_CMD) destroy -var-file=$(TFVARS_FILE)