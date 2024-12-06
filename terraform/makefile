# ENV
TF_DIR = terraform
MODULE_VPC = module.vpc
MODULE_IAM = module.iam
AUTO_APPROVE = -auto-approve

# Default make target - Initializes Terraform, validates, plans, and applies for both modules
.PHONY: all
all: init validate plan-vpc apply-vpc plan-iam apply-iam

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

# Plans Terraform for module.vpc
.PHONY: plan-vpc
plan-vpc:
	@echo "Planning Terraform for module.vpc..."
	terraform plan -target=$(MODULE_VPC)

# Applies Terraform for module.vpc with auto-approve
.PHONY: apply-vpc
apply-vpc:
	@echo "Applying Terraform for module.vpc..."
	terraform apply -target=$(MODULE_VPC) $(AUTO_APPROVE)

# Plans Terraform for module.iam
.PHONY: plan-iam
plan-iam:
	@echo "Planning Terraform for module.iam..."
	terraform plan -target=$(MODULE_IAM)

# Applies Terraform for module.iam with auto-approve
.PHONY: apply-iam
apply-iam:
	@echo "Applying Terraform for module.iam..."
	terraform apply -target=$(MODULE_IAM) $(AUTO_APPROVE)

# Destroys Terraform resources for both modules in order: iam -> vpc
.PHONY: destroy
destroy: destroy-iam destroy-vpc

# Destroys Terraform resources for module.iam
.PHONY: destroy-iam
destroy-iam:
	@echo "Destroying Terraform resources for module.iam..."
	terraform destroy -target=$(MODULE_IAM) $(AUTO_APPROVE)

# Destroys Terraform resources for module.vpc
.PHONY: destroy-vpc
destroy-vpc:
	@echo "Destroying Terraform resources for module.vpc..."
	terraform destroy -target=$(MODULE_VPC) $(AUTO_APPROVE)
