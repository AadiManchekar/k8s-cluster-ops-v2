# ENV
TF_DIR = terraform
MODULE_VPC = module.vpc
AUTO_APPROVE = -auto-approve

# Default make target - Initializes Terraform, validates, plans, and applies module.vpc
.PHONY: all
all: init validate plan apply

# Initializes Terraform working directory and downloads required providers
.PHONY: init
init:
	@echo "Initializing Terraform..."
	terraform init

# Validates the Terraform configuration
.PHONY: validate
validate:
	@echo "Validating Terraform configuration..."
	terraform validate

# Plans Terraform with the target module
.PHONY: plan
plan:
	@echo "Planning Terraform for module.vpc..."
	terraform plan -target=$(MODULE_VPC)

# Applies Terraform for module.vpc with auto-approve
.PHONY: apply
apply:
	@echo "Applying Terraform for module.vpc..."
	terraform apply -target=$(MODULE_VPC) $(AUTO_APPROVE)

# Destroys Terraform resources for module.vpc
.PHONY: destroy
destroy:
	@echo "Destroying Terraform resources for module.vpc..."
	terraform destroy -target=$(MODULE_VPC) $(AUTO_APPROVE)

