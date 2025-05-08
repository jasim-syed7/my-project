output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_ids" {
  description = "Map of subnet IDs"
  value       = { for k, v in aws_subnet.main : k => v.id }
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway (if deployed)"
  value       = var.deploy_nat_gateway ? aws_nat_gateway.main[0].id : null
}
