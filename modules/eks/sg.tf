resource "aws_security_group" "eks_cluster_sg" {
  vpc_id = var.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    self      = true
    protocol  = "-1"
  }

  tags = {
    Name = "eks-cluster-sg"
  }
}
