output "ec2_instance_ids" {
  description = "IDs of the EC2 instances"
  value       = module.ec2.instance_ids
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = module.vpc.subnet_ids
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway (if deployed)"
  value       = module.vpc.nat_gateway_id
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}
