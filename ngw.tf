resource "aws_nat_gateway" "nat" {
  allocation_id     = aws_eip.eip.id
  subnet_id         = aws_subnet.public_subnet[0].id
  connectivity_type = "public"

  tags = {
    Name        = "NAT Gateway"
    Type        = "NAT"
    Environment = var.environment

  }

  depends_on = [aws_eip.eip, aws_subnet.public_subnet]
}
