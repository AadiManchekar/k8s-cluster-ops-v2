terraform {
  backend "s3" {
    bucket = "mocha-eks-state"
    key    = "terraform/state" # Path for the Terraform state file
    region = "us-east-1"
  }
}
