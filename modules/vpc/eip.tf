resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name        = "eip"
    Type        = "eip"
    Environment = var.environment
  }

  depends_on = [aws_internet_gateway.igw]
}

