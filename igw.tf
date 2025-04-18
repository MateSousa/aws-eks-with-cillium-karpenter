resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "igw"
    Type        = "igw"
    Environment = var.environment
  }

  depends_on = [aws_vpc.vpc]
}
