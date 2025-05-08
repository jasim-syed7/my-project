variable "region" {
  description = "AWS region"
  type        = string
}

variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    public            = bool
  }))
}

variable "deploy_nat_gateway" {
  description = "Whether to deploy a NAT Gateway"
  type        = bool
}
