resource "aws_eks_addon" "addon" {
  for_each = var.eks_addons

  cluster_name                = aws_eks_cluster.cluster.name
  addon_name                  = each.key
  addon_version               = each.value.version
  resolve_conflicts_on_update = each.value.resolve_conflicts_on_update != "" ? each.value.resolve_conflicts_on_update : null
  resolve_conflicts_on_create = each.value.resolve_conflicts_on_create != "" ? each.value.resolve_conflicts_on_create : null
  configuration_values        = each.value.configuration_values != "" ? each.value.configuration_values : null
  service_account_role_arn    = each.value.service_account_role_arn != "" ? each.value.service_account_role_arn : null

  dynamic "pod_identity_association" {
    for_each = each.value.pod_identity_association != null ? [each.value.pod_identity_association] : []
    content {
      role_arn        = pod_identity_association.value.role_arn
      service_account = pod_identity_association.value.service_account
    }
  }

  depends_on = [
    aws_eks_node_group.node_group,
  ]
}
