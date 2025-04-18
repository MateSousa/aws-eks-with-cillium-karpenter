resource "aws_eks_cluster" "cluster" {
  name     = var.eks.name
  version  = var.eks.version
  role_arn = aws_iam_role.eks_cluster_role.arn

  access_config {
    authentication_mode                         = var.eks.authentication_mode                         // Default "API", CONFIG_MAP is deprecated
    bootstrap_cluster_creator_admin_permissions = var.eks.bootstrap_cluster_creator_admin_permissions // Default false
  }

  vpc_config {
    subnet_ids              = aws_subnet.private_subnet[*].id
    endpoint_private_access = var.eks.endpoint_private_access
    endpoint_public_access  = var.eks.endpoint_public_access
    public_access_cidrs     = var.eks.api_allowed_cidrs
    security_group_ids      = [aws_security_group.eks_cluster_sg.id]
  }

  dynamic "encryption_config" {
    for_each = var.eks.encryption_enabled ? [1] : []
    content {
      provider {
        key_arn = aws_kms_key.eks_encryption_key[0].arn
      }
      resources = ["secrets"]
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
  ]
}


