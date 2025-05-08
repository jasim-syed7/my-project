Advanced Terraform Features
This project demonstrates advanced Terraform features: count, for_each, conditional expressions, and dependencies.
Prerequisites

Terraform >= 1.5.0
AWS account with VPC, EC2, NAT Gateway permissions
AWS key pair for SSH

Setup

Clone the repository.
Update terraform.tfvars with your key pair name and NAT Gateway preference.
Run:terraform init
terraform apply


Verify resources in the AWS console.

Resources

VPC with dynamically created subnets (for_each)
Multiple EC2 instances (count)
Conditional NAT Gateway


