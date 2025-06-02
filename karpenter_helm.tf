resource "aws_eks_addon" "pod_identity_agent_addon" {
  cluster_name = aws_eks_cluster.cluster.name
  addon_name   = "eks-pod-identity-agent"

  depends_on = [
    aws_eks_cluster.cluster,
    aws_eks_node_group.node_group,
  ]
}

resource "helm_release" "karpenter_eks" {
  namespace = "kube-system"

  name                = "karpenter"
  repository          = "oci://public.ecr.aws/karpenter"
  repository_username = data.aws_ecrpublic_authorization_token.token.user_name
  repository_password = data.aws_ecrpublic_authorization_token.token.password
  chart               = "karpenter"
  version             = "1.3.3"
  wait                = true

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.karpenter_controller.arn
  }

  set {
    name  = "settings.clusterName"
    value = aws_eks_cluster.cluster.name
  }

  set {
    name  = "settings.clusterEndpoint"
    value = aws_eks_cluster.cluster.endpoint
  }

  set {
    name  = "aws.defaultInstanceProfile"
    value = aws_iam_instance_profile.karpenter.name
  }

  depends_on = [
    aws_iam_role.karpenter_controller,
    aws_eks_addon.pod_identity_agent_addon,
    aws_iam_role_policy_attachment.karpenter_controller_policy_attachment,
    aws_iam_role_policy_attachment.karpenter_ssm_policy,
    aws_iam_instance_profile.karpenter,
  ]
}

resource "aws_eks_access_entry" "karpenter_access" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = aws_iam_role.karpenter_node_role.arn
  type          = "EC2_LINUX"
  depends_on = [
    aws_eks_addon.pod_identity_agent_addon,
  ]
}


resource "aws_eks_pod_identity_association" "karpenter_pods_identity_association" {
  cluster_name    = aws_eks_cluster.cluster.name
  namespace       = "kube-system"
  service_account = "karpenter"
  role_arn        = aws_iam_role.karpenter_controller.arn
  depends_on = [
    aws_eks_addon.pod_identity_agent_addon,
  ]
}


data "kubectl_path_documents" "provisioner_manifests" {
  count = var.deploy_provisioners ? 1 : 0

  pattern = var.provisioner_manifests_paths
  vars = {
    cluster_name = var.eks.name
  }
}

resource "kubectl_manifest" "provisioners" {
  for_each  = var.deploy_provisioners ? data.kubectl_path_documents.provisioner_manifests[0].manifests : {}
  yaml_body = each.value

  depends_on = [
    helm_release.karpenter_eks,
  ]
}



