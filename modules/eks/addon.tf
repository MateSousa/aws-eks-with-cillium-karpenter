resource "aws_eks_addon" "addon" {
  for_each = var.addons

  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = each.key

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.node_group,
  ]
}
