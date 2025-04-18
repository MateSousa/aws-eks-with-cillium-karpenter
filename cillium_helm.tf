resource "null_resource" "patch_aws_nodes" {
  triggers = {
    eks_name = aws_eks_cluster.cluster.name
  }

  provisioner "local-exec" {
    command = <<EOT
      aws eks update-kubeconfig --name ${aws_eks_cluster.cluster.name} --region ${var.aws_region}
      kubectl -n kube-system patch daemonset aws-node --type='strategic' -p='{"spec":{"template":{"spec":{"nodeSelector":{"io.cilium/aws-node-enabled":"true"}}}}}'
    EOT
  }

  depends_on = [
    aws_eks_node_group.node_group
  ]
}

resource "helm_release" "cillium" {
  name       = "cilium"
  chart      = "cilium"
  repository = var.cillium.chart_repository
  namespace  = var.cillium.namespace
  version    = var.cillium.version

  dynamic "set" {
    for_each = var.cillium.sets
    content {
      name  = set.key
      value = set.value
    }
  }

  set {
    name  = "hubble.relay.enabled"
    value = var.cillium.hubble_enabled
  }

  set {
    name  = "hubble.ui.enabled"
    value = var.cillium.hubble_ui_enabled
  }

  depends_on = [null_resource.patch_aws_nodes]
}
