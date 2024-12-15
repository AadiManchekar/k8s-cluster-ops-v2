# ENV
TF_DIR = terraform

MODULE_VPC = module.vpc
MODULE_IAM = module.iam
MODULE_EKS = module.eks
MODULE_METRICS = module.metrics_server
MODULE_AUTOSCALER = module.cluster_autoscaler
AUTO_APPROVE = -auto-approve

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

# Plans Terraform for module.vpc, module.iam
.PHONY: plan
plan:
	@echo "Planning Terraform for all modules..."
	terraform plan -target=$(MODULE_VPC)
	terraform plan -target=$(MODULE_IAM)
	terraform plan -target=$(MODULE_EKS)
	terraform plan -target=$(MODULE_METRICS)
	terraform plan -target=$(MODULE_AUTOSCALER)

# Applies Terraform for module.vpc, module.iam with auto-approve
.PHONY: apply
apply:
	@echo "Applying Terraform for all modules..."
	terraform apply -target=$(MODULE_VPC) $(AUTO_APPROVE)
	terraform apply -target=$(MODULE_IAM) $(AUTO_APPROVE)
	terraform apply -target=$(MODULE_EKS) $(AUTO_APPROVE)
	terraform apply -target=$(MODULE_METRICS) $(AUTO_APPROVE)
	terraform apply -target=$(MODULE_AUTOSCALER) $(AUTO_APPROVE)

# Destroys Terraform resources for both modules in order: eks -> iam -> vpc
.PHONY: destroy
destroy:
	@echo "Destroying Terraform resources for all modules..."
	terraform destroy -target=$(MODULE_AUTOSCALER) $(AUTO_APPROVE)
	terraform destroy -target=$(MODULE_METRICS) $(AUTO_APPROVE)
	terraform destroy -target=$(MODULE_EKS) $(AUTO_APPROVE)
	terraform destroy -target=$(MODULE_IAM) $(AUTO_APPROVE)
	terraform destroy -target=$(MODULE_VPC) $(AUTO_APPROVE)
