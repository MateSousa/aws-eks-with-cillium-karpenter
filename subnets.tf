resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))

  tags = {
    Name                     = "private-${var.environment}-${data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]}"
    Type                     = "subnet"
    Environment              = var.environment
    "karpenter.sh/discovery" = var.eks.name
  }

  depends_on = [aws_vpc.vpc]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name                     = "private-${var.environment}"
    Type                     = "route-table"
    Environment              = var.environment
    "karpenter.sh/discovery" = var.eks.name
  }

  depends_on = [aws_subnet.private_subnet, aws_nat_gateway.nat, aws_internet_gateway.igw]

  lifecycle {
    ignore_changes = [route]
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
  route_table_id = element(aws_route_table.private[*].id, count.index)

  depends_on = [aws_subnet.private_subnet]
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name        = "public-${var.environment}-${data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]}"
    Type        = "Subnet"
    Environment = var.environment
  }

  depends_on = [aws_vpc.vpc]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "public-${var.environment}"
    Type        = "Route Table"
    Environment = var.environment
  }

  depends_on = [aws_subnet.public_subnet, aws_nat_gateway.nat, aws_internet_gateway.igw]


  lifecycle {
    ignore_changes = [route]
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = element(aws_route_table.public[*].id, count.index)

  depends_on = [aws_subnet.public_subnet]
}

