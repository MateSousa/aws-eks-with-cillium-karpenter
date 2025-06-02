resource "helm_release" "argocd_rollouts" {
  name             = "argocd-rollouts"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-rollouts"
  namespace        = "argocd-rollouts"
  create_namespace = true
  version          = var.argocd_rollouts_chart_version

  dynamic "set" {
    for_each = var.argocd_rollouts_set
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set" {
    for_each = var.enable_argocd_rollouts_dashboard ? [1] : []
    content {
      name  = "dashboard.enabled"
      value = true
    }
  }
}
