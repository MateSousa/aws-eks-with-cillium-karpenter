resource "aws_iam_role" "karpenter_controller" {
  name               = "karpenter-controller-${aws_eks_cluster.cluster.name}"
  assume_role_policy = data.aws_iam_policy_document.pods_trust_relantionship.json
  tags               = var.tags
}

resource "aws_iam_policy" "karpenter_controller_policy" {
  name        = "karpenter-controller-${aws_eks_cluster.cluster.name}"
  description = "IAM policy for Karpenter controller"
  policy      = data.aws_iam_policy_document.karpenter_controller_policy.json
}

resource "aws_iam_role_policy_attachment" "karpenter_controller_policy_attachment" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = aws_iam_policy.karpenter_controller_policy.arn

  depends_on = [
    aws_iam_role.karpenter_controller,
    aws_iam_policy.karpenter_controller_policy,
  ]
}

resource "aws_iam_role_policy_attachment" "karpenter_ssm_policy" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = data.aws_iam_policy.ssm_managed_instance.arn
}

resource "aws_iam_instance_profile" "karpenter" {
  name = "KarpenterNodeInstanceProfile-${aws_eks_cluster.cluster.name}"
  role = aws_iam_role.karpenter_controller.name
}


