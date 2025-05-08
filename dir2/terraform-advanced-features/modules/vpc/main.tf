resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "advanced-vpc"
  }
}

resource "aws_subnet" "main" {
  for_each                = var.subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.public
  tags = {
    Name = "${each.key}-subnet"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "advanced-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = { for k, v in var.subnets : k => v if v.public }
  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  count = var.deploy_nat_gateway ? 1 : 0
  vpc   = true
  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "main" {
  count         = var.deploy_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.main["public-1"].id
  tags = {
    Name = "advanced-nat-gateway"
  }

  depends_on = [aws_subnet.main, aws_internet_gateway.main]
}

resource "aws_route_table" "private" {
  count  = var.deploy_nat_gateway ? 1 : 0
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[0].id
  }
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private" {
  for_each       = var.deploy_nat_gateway ? { for k, v in var.subnets : k => v if !v.public } : {}
  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.private[0].id
}
