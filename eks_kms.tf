resource "aws_kms_key" "eks_encryption_key" {
  count                    = var.eks.encryption_enabled ? 1 : 0
  description              = "KMS key for EKS ${var.eks.name} encryption"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  deletion_window_in_days  = 7
  enable_key_rotation      = true

  tags = var.tags
}


