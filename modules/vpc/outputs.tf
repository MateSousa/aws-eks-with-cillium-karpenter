output "vpc" {
  description = "Output VPC"
  value = {
    "arn"                  = aws_vpc.vpc.arn
    "id"                   = aws_vpc.vpc.id
    "cidr_block"           = aws_vpc.vpc.cidr_block
    "instance_tenancy"     = aws_vpc.vpc.instance_tenancy
    "enable_dns_support"   = aws_vpc.vpc.enable_dns_support
    "enable_dns_hostnames" = aws_vpc.vpc.enable_dns_hostnames
  }
}

output "public_subnets" {
  description = "Output public subnets"
  value       = aws_subnet.public_subnet.*.id
}

output "private_subnets" {
  description = "Output private subnets"
  value       = aws_subnet.private_subnet.*.id
}

output "igw" {
  description = "Output internet gateway"
  value = {
    "id" = aws_internet_gateway.igw.id
  }
}

output "nat" {
  description = "Output nat gateway"
  value = {
    "id" = aws_nat_gateway.nat.id
  }
}
