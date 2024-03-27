#----------------------------------------------------------------------
# Vpc
#----------------------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.name
  }
}

#----------------------------------------------------------------------
# Internet Gateway
#----------------------------------------------------------------------
resource "aws_internet_gateway" "main" {
  count = local.has_public_subnet ? 1 : 0

  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway_attachment" "main" {
  count = local.has_public_subnet ? 1 : 0

  vpc_id              = aws_vpc.main.id
  internet_gateway_id = aws_internet_gateway.main[0].id
}

#----------------------------------------------------------------------
# Subnets
#----------------------------------------------------------------------
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.main.id
  availability_zone       = element(var.azs, count.index)
  cidr_block              = var.public_subnets[count.index].cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-${var.public_subnet_prefix}-${element(var.azs, count.index)}"
    Tier = coalesce(var.public_subnets[count.index].tier, var.public_subnet_prefix)
    Type = var.public_subnet_prefix
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.main.id
  availability_zone = element(var.azs, count.index)
  cidr_block        = var.private_subnets[count.index].cidr

  tags = {
    Name = "${var.name}-${var.private_subnet_prefix}-${element(var.azs, count.index)}"
    Tier = coalesce(var.private_subnets[count.index].tier, var.private_subnet_prefix)
    Type = var.private_subnet_prefix
  }
}

#----------------------------------------------------------------------
# Route Tables
#----------------------------------------------------------------------
resource "aws_route_table" "public" {
  count = local.has_public_subnet ? 1 : 0

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-public"
  }
}

resource "aws_route" "to_igw" {
  count = local.has_public_subnet ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = local.all_ips
  gateway_id             = aws_internet_gateway.main[0].id
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_route_table" "private" {
  count  = length(var.private_subnets) / length(var.azs)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-private"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  route_table_id = element(aws_route_table.private[*].id, floor(length(aws_route_table.private) / length(var.azs)))
  subnet_id      = aws_subnet.private[count.index].id
}
