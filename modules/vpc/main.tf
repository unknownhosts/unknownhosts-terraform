////////////////////////////////////////////////
// VPC
////////////////////////////////////////////////
resource "aws_vpc" "this" {

  instance_tenancy = var.instance_tenancy
  cidr_block       = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    {
      Name = format("%s-vpc", var.name_prefix)
    },
    var.tags,
    var.vpc_tags,
  )
}

////////////////////////////////////////////////
// Public Subnet
////////////////////////////////////////////////
resource "aws_subnet" "public" {
  # If Variable(public_subnet_cidr) is set, create public subnets
  count = length(var.public_subnet_cidr) > 0 ? length(var.public_subnet_cidr) : 0

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = var.available_azs[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
      Name = format("%s-public-subnet-0${count.index + 1}", var.name_prefix)
    },
    var.tags,
    var.public_subnet_tags
  )
}


////////////////////////////////////////////////
// Private Subnet
////////////////////////////////////////////////
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr) > 0 ? length(var.private_subnet_cidr) : 0

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_subnet_cidr[count.index]
  availability_zone       = length(regexall("^[a-z]{2}-", element(var.available_azs, count.index))) > 0 ? element(var.available_azs, count.index) : null
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = format("%s-private-subnet-0${count.index + 1}", var.name_prefix)
    },
    var.tags,
    var.private_subnet_tags
  )
}

////////////////////////////////////////////////
// DB Subnet
////////////////////////////////////////////////
resource "aws_subnet" "db" {
  count = length(var.db_subnet_cidr) > 0 ? length(var.db_subnet_cidr) : 0

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.db_subnet_cidr[count.index]
  availability_zone       = length(regexall("^[a-z]{2}-", element(var.available_azs, count.index))) > 0 ? element(var.available_azs, count.index) : null
  map_public_ip_on_launch = false

  tags = merge(
    {
      Name = format("%s-db-subnet-0${count.index + 1}", var.name_prefix)
    },
    var.tags,
    var.db_subnet_tags
  )
}


////////////////////////////////////////////////
// Internet Gateway
////////////////////////////////////////////////
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = format("%s-igw", var.name_prefix)
    },
    var.tags,
  )
}


////////////////////////////////////////////////
// Elastic IP for NAT Gateway
////////////////////////////////////////////////
resource "aws_eip" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  vpc = true
  tags = merge(
    {
      Name = format("%s-nat-eip", var.name_prefix)
    },
    var.tags,
  )
}


////////////////////////////////////////////////
// NAT Gateway
////////////////////////////////////////////////
resource "aws_nat_gateway" "this" {
  count         = var.enable_nat_gateway ? 1 : 0

  allocation_id = aws_eip.this[0].id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    {
      Name = format("%s-nat-gw", var.name_prefix)
    },
    var.tags,
  )

  depends_on = [aws_internet_gateway.this]
}

////////////////////////////////////////////////
// Public Route Table
////////////////////////////////////////////////
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = format("%s-public-route-table", var.name_prefix)
    },
    var.tags,
  )
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id

  timeouts {
    create = "5m"
  }
}

////////////////////////////////////////////////
// Private Route Table
////////////////////////////////////////////////
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_cidr) > 0 && var.enable_nat_gateway ? 1 : 0
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.this.*.id, count.index)
  }

  tags = merge(
    {
      Name = format("%s-private-route-table", var.name_prefix)
    },
    var.tags,
  )
}


////////////////////////////////////////////////
// DB Route Table
////////////////////////////////////////////////
resource "aws_route_table" "db" {
  count  = length(var.db_subnet_cidr) > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = format("%s-db-route-table", var.name_prefix)
    },
    var.tags,
  )
}

////////////////////////////////////////////////
// Route Table Association
////////////////////////////////////////////////
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id

}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr)

  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

resource "aws_route_table_association" "db" {
  count = length(var.db_subnet_cidr)

  subnet_id      = element(aws_subnet.db.*.id, count.index)
  route_table_id = element(aws_route_table.db.*.id, count.index)
}