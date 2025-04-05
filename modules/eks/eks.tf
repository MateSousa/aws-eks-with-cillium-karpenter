resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks.name
  version  = var.eks.version
  role_arn = aws_iam_role.eks_cluster_role.arn

  access_config {
    authentication_mode                         = var.eks.authentication_mode
    bootstrap_cluster_creator_admin_permissions = var.eks.bootstrap_cluster_creator_admin_permissions
  }

  vpc_config {
    subnet_ids              = var.vpc.subnets
    endpoint_private_access = var.eks.endpoint_private_access
    endpoint_public_access  = var.eks.endpoint_public_access
    security_group_ids      = [aws_security_group.eks_cluster_sg.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
  ]
}

