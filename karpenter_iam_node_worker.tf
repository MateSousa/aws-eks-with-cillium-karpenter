locals {
  karpenter_node_role_policies = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  ]
}

resource "aws_iam_role" "karpenter_node_role" {
  name               = "${aws_eks_cluster.cluster.name}-karpenter-node-role"
  assume_role_policy = data.aws_iam_policy_document.node_assume_role.json

  tags = merge(
    var.tags,
    {
      Name = "${aws_eks_cluster.cluster.name}-karpenter-node-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "karpenter_node_role_policy_attachment" {
  for_each = toset(local.karpenter_node_role_policies)

  role       = aws_iam_role.karpenter_node_role.name
  policy_arn = each.value
}
